class ChargesController < ApplicationController
  after_action :upgrade_premium, only: :create

  def new
    @stripe_btn_data = {
      key: "#{Rails.configuration.stripe[:publishable_key]}",
      description: "BigMoneyMembership - #{current_user.email}",
      amount: Amount.default
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
      amount: Amount.default,
      description: "BigMoneyMembership - #{current_user.email}",
      currency: 'usd'
    )

    flash[:notice] = "Thank you for the payment #{current_user.email}! You have purchased the Premium Membership."
    redirect_to root_path

    # Stripe will send back CardErrors, with friendly messages when something goes wrong.
    # This `rescue block` catches and displays those errors.
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end

  private

  def upgrade_premium
    user = User.find(current_user.id)
    user.update_attributes(role: "premium")
    user.save
  end
end
