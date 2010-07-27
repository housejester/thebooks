package com.thebooks.controllers
import com.thebooks.domain.Transaction
import com.thebooks.domain.TransactionItem
import java.util.Calendar

class UserController {
	def beforeInterceptor = [action:this.&checkLoggedIn,except:['login','logout','register','noAccess']]

	def user = null
    List transactions
    Integer pastUnreconciledCount
    Transaction lastReconciled
    Date lastMonth;
    Date nextMonth;
    Date rangeStart;
    Date rangeEnd;
    String rangePattern = "MMMM";

	def checkLoggedIn = {
		if(!session.user){
			redirect(controller:'user', action : 'login')
			return false
		}
		user = session.user
	}
	
	def login = { 
		if(request.method == 'POST'){
		 	session.user = com.thebooks.domain.User.findByEmail(params['email']) 
		}
	    if (session.user) 
	     	redirect(controller:'user', action:'home') 
	  	else 
			render(view:'login')
	 }
  def reconcile = {
    def tx = TransactionItem.get(params.txId);
    tx.reconciled = params.reconciled == 'true';
    if(tx.save()){
      render(status:204);
      return;
    };
    render(status: 503, text: 'Failed to update transaction ${params.id}')
  }
  def markPaid = {
    def tx = TransactionItem.get(params.txId);
    tx.paid = params.paid == 'true';
    if(tx.save()){
      render(status:204);
      return;
    };
    render(status: 503, text: 'Failed to mark transaction ${params.id} as paid/unpaid')
  }
  def updateTransaction = {
    def tx = TransactionItem.get(params.id);
    if(!params.clearDate){
      tx.delete();
      redirect(url:request.getHeader('referer'))
      return;
    }

    params.usbankAmount = parseMoney(params.usbankAmount);
    params.commerceAmount = parseMoney(params.commerceAmount);
    tx.properties = params
    def date = new Date();
    date.month = tx.clearDate.month;
    date.date = tx.clearDate.date;
	if(date.month > 9 && (new Date()).month < 4){
	date.year -= 1;
	}
    tx.setClearDate(date);
    if(!tx.save()){
      tx.errors.each {
           println it
      }
      redirect(controller:'user', action:'home', params:[error:'error'])
    }else{
      redirect(url:request.getHeader('referer'))
    }
  }
    def addTransaction = {
      params.usbankAmount = parseMoney(params.usbankAmount);
      params.commerceAmount = parseMoney(params.commerceAmount);

        def tx = new TransactionItem(params);
      
        def date = new Date();
        date.month = tx.clearDate.month;
        date.date = tx.clearDate.date;
	if(date.month < 3 && (new Date()).month > 9){
		date.year = date.year+1; //figure out a better way to jump years naturally
	}
	if(date.month > 9 && (new Date()).month < 4){
	date.year -= 1;
	}
	if("true".equals(params.copyToNextMonth)){
		java.util.Calendar calen = java.util.Calendar.getInstance();
		calen.setTime(date);
		calen.roll(java.util.Calendar.MONTH, 1);
		date = calen.getTime();
	}
    tx.setClearDate(date);
        tx.setClearDate(date);
	if(tx.category != null && !"".equals(tx.category)){
		tx.category = tx.category.toLowerCase();
	}

        if(!tx.save(flush:true)){
           tx.errors.each {
                println it
           }
          redirect(controller:'user', action:'home', params:[error:'error'])
        }else{
          redirect(url:request.getHeader('referer'))
        }
    }
    def parseMoney(amount){
      if(!amount){
        return 0;
      }
      def index = amount.indexOf(".");
      if(index == -1){
        amount = amount + ".00";
      }else if(amount.length() - index == 1){
        amount = amount + "00";
      }else if(amount.length() - index == 2){
        amount = amount + "0";
      }else if(amount.length() - index > 3){
        amount = amount.substring(0, index+3);
      }
      def result = amount.replaceAll("\\.", "");
      return result;
    }
	def home = {
		if(!user.setupComplete){
			render(view : 'homeNotSetupYet')
			return;
		}
      
        def lastRec = Transaction.withCriteria{
          eq("reconciled", true)
          maxResults(1)
          order("clearDate","desc")
          order("id", "desc")
        }
        if(lastRec.size() == 0){
          lastReconciled = new Transaction();
          pastUnreconciledCount = 0
        }else{
          lastReconciled = lastRec.get(0)
          pastUnreconciledCount = Transaction.countByClearDateLessThanAndReconciled(lastReconciled.clearDate, 0)
        }
        rangeStart = getRangeStart(params.year, params.month, params.day);
        rangeEnd = getRangeEnd(params.year, params.month, params.day);
        rangePattern = getRangePattern(params.year, params.month, params.day);

      lastMonth = getPrevMonth(rangeStart);
      nextMonth = rangeEnd;
        transactions = Transaction.withCriteria{
          ge("clearDate", rangeStart);
          lt("clearDate", rangeEnd);
          order("clearDate","asc")
          order("id", "asc")
        }
	}
  def getRangePattern(year,month,day){
    if(day == null && month == null && year == null){
      return 'MMMM';
    }
    if(day == null && month == null){
      return 'yyyy';
    }
    if(day == null){
      if(year == (new Date()).format('yyyy')){
        return 'MMMM';
      }
      return 'MMMM yyyy';
    }
    return 'MMMM dd, yyyy';
  }
  def getRangeStart(year, month, day){
    if(day == null && month == null && year == null){
      return Date.parse('MM/yyyy', (new Date()).format("MM/yyyy"));
    }
    if(day == null && month == null){
      return Date.parse('yyyy', year);
    }
    if(day == null){
      return Date.parse('MMM/yyyy', month+"/"+year);
    }
    return Date.parse('MMM/dd/yyyy', month+"/"+day+"/"+year);
  }
  def getPrevMonth(date){
    def cal = new GregorianCalendar();
    cal.time = date;
    cal.add(Calendar.MONTH, -1)
    return cal.time;
  }
  def getRangeEnd(year, month, day){
    if(day == null && month == null && year == null){
      def cal = new GregorianCalendar();
      cal.time = Date.parse('MM/yyyy', (new Date()).format("MM/yyyy"));
      cal.add(Calendar.MONTH, 1)
      return cal.time;
    }
    if(day == null && month == null){
      def cal = new GregorianCalendar();
      cal.time = Date.parse('yyyy', year);
      cal.add(Calendar.YEAR, 1);
      return cal.time;
    }
    if(day == null){
      def cal = new GregorianCalendar();
      cal.time = Date.parse('MMM/yyyy', month+"/"+year);
      cal.add(Calendar.MONTH, 1)
      return cal.time;
    }
    def cal = new GregorianCalendar();
    cal.time = Date.parse('MMM/dd/yyyy', month+"/"+day+"/"+year);
    cal.add(Calendar.DAY_OF_MONTH, 1)
    return cal.time;
  }
	def dojo = {
		render(view:'dojo-home')
	}
	def oasis = {
		render(view:'oasis-home')
	}
	def logout = {
		session.invalidate();
		redirect(uri:'/');
	}
	
	def accountList = {
		/* eventually, move this to an AccountController */
	}
	
	def letMeIn = {
		user.setupComplete = true
		user.merge()
		redirect(action:'home')
	}
	def noAccess = {
	}
	def register = {
		if(request.method == 'POST'){
			user = new com.thebooks.domain.User(params)
			if(params['password'] != params['confirm_password'])
				user.errors.reject("user.confirm_password.match")
			if(!user.hasErrors() && user.save()){
				session.user = user
				redirect(action:'home')
				return;
			}
		}
	}
}
