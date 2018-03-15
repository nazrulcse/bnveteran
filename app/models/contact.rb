# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  phone      :string
#  message    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Contact < ApplicationRecord

  validates_presence_of :name, :email, :message

end
