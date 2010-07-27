package com.thebooks.domain

class TransactionItem {
  Long id
  Long version
  Date clearDate
  String description
  String category
  Integer commerceAmount
  Integer usbankAmount
  Boolean reconciled
  Boolean paid

  static mapping = {
    table 'transaction'
    clearDate column:"clear_date"
    commerceAmount column:"commerce_amt"
    usbankAmount column:"usbank_amt"
    category column:"tx_category"
  }

  def static constraints =
  {
    id()
    clearDate()
    description()
    category()
    commerceAmount()
    usbankAmount()
  }

}
