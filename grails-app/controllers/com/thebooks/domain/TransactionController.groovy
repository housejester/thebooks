package com.thebooks.domain

class TransactionController {
    
    def index = { redirect(action:list,params:params) }

    // the delete, save and update actions only accept POST requests
    def allowedMethods = [delete:'POST', save:'POST', update:'POST']

    def list = {
        if(!params.max) params.max = 10
        [ transactionInstanceList: Transaction.list( params ) ]
    }

    def show = {
        def transactionInstance = Transaction.get( params.id )

        if(!transactionInstance) {
            flash.message = "Transaction not found with id ${params.id}"
            redirect(action:list)
        }
        else { return [ transactionInstance : transactionInstance ] }
    }

    def delete = {
        def transactionInstance = Transaction.get( params.id )
        if(transactionInstance) {
            transactionInstance.delete()
            flash.message = "Transaction ${params.id} deleted"
            redirect(action:list)
        }
        else {
            flash.message = "Transaction not found with id ${params.id}"
            redirect(action:list)
        }
    }

    def edit = {
        def transactionInstance = Transaction.get( params.id )

        if(!transactionInstance) {
            flash.message = "Transaction not found with id ${params.id}"
            redirect(action:list)
        }
        else {
            return [ transactionInstance : transactionInstance ]
        }
    }

    def update = {
        def transactionInstance = Transaction.get( params.id )
        if(transactionInstance) {
            transactionInstance.properties = params
            if(!transactionInstance.hasErrors() && transactionInstance.save()) {
                flash.message = "Transaction ${params.id} updated"
                redirect(action:show,id:transactionInstance.id)
            }
            else {
                render(view:'edit',model:[transactionInstance:transactionInstance])
            }
        }
        else {
            flash.message = "Transaction not found with id ${params.id}"
            redirect(action:edit,id:params.id)
        }
    }

    def create = {
        def transactionInstance = new Transaction()
        transactionInstance.properties = params
        return ['transactionInstance':transactionInstance]
    }

    def save = {
        def transactionInstance = new Transaction(params)
        if(!transactionInstance.hasErrors() && transactionInstance.save()) {
            flash.message = "Transaction ${transactionInstance.id} created"
            redirect(action:show,id:transactionInstance.id)
        }
        else {
            render(view:'create',model:[transactionInstance:transactionInstance])
        }
    }
}
