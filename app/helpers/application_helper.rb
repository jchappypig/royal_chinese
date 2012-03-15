module ApplicationHelper

  def company_name
    "Royal Chinese"
  end

  def company_full_name
    company_name + " Restaurant"
  end

  def company_contact_email
    "royal_chinese@hotmail.com"
  end

  def company_contact_email_with_name
    "\"#{company_name}\" <#{company_contact_email}>"
  end

end
