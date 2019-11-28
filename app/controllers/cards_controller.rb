class CardsController < ApplicationController
  before_action :set_card, only: [:show, :update]

  def index
    @cards = policy_scope(Card).where(user_id: current_user.id)
    @places = policy_scope(Place)
  end

  def new
    @card = Card.new
    authorize @card
  end

  def create
    @card = Card.new(card_params)
    @card.user = current_user
    authorize @card

    if @card.save
      redirect_to cards_path
    else
      render :new
    end
  end

  def show
    @places = Place.all
    authorize @places
  end

  def destroy
  end

  def update
    @card.stamp_count += if @card.stam_count < 5
  end

  private

  def set_card
    @card = Card.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:place_id)
  end
end
