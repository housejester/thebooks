package com.thebooks.domain

class Transaction {
  Long id
  Long version
  Date clearDate
  String description
  String category
  Integer commerceAmount
  Integer commerceBalance
  Integer usbankAmount
  Integer usbankBalance
  Integer balance
  Boolean reconciled

  static mapping = {
    clearDate column:"clear_date"
    commerceAmount column:"commerce_amt"
    commerceBalance column:"commerce_balance"
    usbankAmount column:"usbank_amt"
    usbankBalance column:"usbank_balance"
    category column:"tx_category"
  }

  def static constraints =
  {
    id()
    clearDate()
    description()
    category()
    commerceAmount()
    commerceBalance()
    usbankAmount()
    usbankBalance()
    balance()
  }
}
