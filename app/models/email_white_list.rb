class EmailWhiteList
  def self.include?(email)
    email_white_list = ["hhuang@thoughtworks.com", "airwomanzhy@hotmail.com", "jchappypig@hotmail.com"]
    email_white_list.include? email
  end
end