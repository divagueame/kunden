class CustomersController < ApplicationController
  before_action :set_customer, only: %i[ edit destroy ]

  def index
    @customers = Customer.all
    redirect_to new_customer_path unless @customers.any?
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        format.html { redirect_to customers_path, notice: "Kunde wurde erfolgreich erstellt." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @customer.destroy!

    respond_to do |format|
      format.html { redirect_to customers_url, notice: "Kunde wurde erfolgreich gelöscht." }
    end
  end

  private
  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email)
  end
end
