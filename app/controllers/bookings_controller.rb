class BookingsController < ApplicationController
  def index
    @bookings = policy_scope(Booking)
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def new
    @booking = Booking.new
    authorize @booking
  end
  #new branch

  def create
    @booking = Booking.new(booking_params)
    @booking.user = current_user
    authorize @booking
    @experience = @booking.experience

    if @booking.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
    authorize @booking
  end

  def update
    authorize @booking
  end

  def destroy
    authorize @booking
  end

  private

  def booking_params
    params.require(:booking).permit(:user_id, :experience_id, :date, :state)
  end

end
