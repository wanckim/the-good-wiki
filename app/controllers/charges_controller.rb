class ChargesController < ApplicationController
  include AmountModule

  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "BigMoneyMembership - #{current_user.email}",
      amount: default
    }
  end

  def create
    # Creates a Stripe Customer object, for associating with the charge
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )

    # Where the real magic happens
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: default,
      description: "BigMoneyMembership - #{current_user.email}",
      currency: 'usd'
    )

    current_user.update(role: 'premium')
    flash[:notice] = "Thank you for the payment #{current_user.email}! You have purchased the Premium Membership."
    redirect_to root_path

    # Stripe will send back CardErrors, with friendly messages when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
end
