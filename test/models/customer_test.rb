require "test_helper"

class CustomerTest < ActiveSupport::TestCase
  test "validates presence of email" do
    customer = Customer.new
    assert_not customer.valid?
    assert_includes customer.errors[:email], "E-Mail darf nicht leer sein"
  end

  test "validates incorrect format of email" do
    customer = Customer.new(email: "invalid_email")
    assert_not customer.valid?
    assert_includes customer.errors[:email], "Dies ist keine gültige E-Mail-Adresse"
  end

  test "validates correct format of email" do
    customer = Customer.new(email: "valid@email.com")
    assert customer.valid?
  end

  test "validates uniqueness of email" do
    existing_customer = Customer.create(email: "test@example.com")

    customer = Customer.new(email: "test@example.com")
    assert_not customer.valid?
    assert_includes customer.errors[:email], "Diese E-Mail-Adresse wird bereits verwendet"
  end

  test "validates uniqueness of email (case-insensitive)" do
    existing_customer = Customer.create(email: "test@example.com")

    customer = Customer.new(email: "TEST@example.com")
    assert_not customer.valid?
    assert_includes customer.errors[:email], "Diese E-Mail-Adresse wird bereits verwendet"
  end
end
