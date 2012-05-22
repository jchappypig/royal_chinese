module ApplicationHelper

  def company_name
    'Royal Chinese'
  end

  def company_full_name
    company_name + ' Restaurant'
  end

  def company_contact_email
    'royal_chinese@hotmail.com'
  end

  def company_address
    '35 Flinders Street, Wollongong, NSW 2500'
  end

  def company_phone
    '(02) 4226 9853'
  end

  def company_contact_email_with_name
    "\'#{company_name}\' <#{company_contact_email}>"
  end

end
