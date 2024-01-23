class Customer < ApplicationRecord
  validates :email,
    presence: { message: "E-Mail darf nicht leer sein" },
    email: { message: "Dies ist keine gültige E-Mail-Adresse" },
    uniqueness: { case_sensitive: false, message: "Diese E-Mail-Adresse wird bereits verwendet" }
end
