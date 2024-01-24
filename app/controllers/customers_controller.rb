class CustomersController < ApplicationController
  before_action :set_customer, only: %i[ edit destroy ]

  def index
    @customers = Customer.all.reverse
    redirect_to new_customer_path unless @customers.any?
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)

    respond_to do |format|
      if @customer.save
        success_msg = "Kunde wurde erfolgreich erstellt."
        format.turbo_stream do 
          flash.now[:success] = success_msg
          render turbo_stream:
            [
              turbo_stream.prepend('customers', partial: 'customer', locals: { customer: @customer }),
              turbo_stream.update('new_customer', partial: 'new_customer_link'),
              turbo_stream.update('flash-messages', partial: 'partials/flash')
            ]
        end
        format.html { redirect_to customers_path, notice: success_msg }
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
