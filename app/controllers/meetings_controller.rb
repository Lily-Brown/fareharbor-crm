class MeetingsController < ApplicationController
  before_action :get_meeting, only: [:show, :edit, :update, :destroy]

  def index
    @meetings = Meeting.all.order(:date)
  end

  def new
    @meeting = Meeting.new
    @meeting.date = Time.now
  end

  def create
    @meeting = Meeting.new(meeting_params)

    if @meeting.save
      flash[:success] = "Meeting added."
      redirect_to meeting_path(@meeting)
    else
      flash[:error] = "Meeting has not been added: " +  @meeting.errors.full_messages.join(". ") + "."
      redirect_to meeting_path(@meeting)
    end
  end

  def show
    @features = Feature.where(:meeting_id => @meeting.id).order(:status)
  end

  def edit
  end

  def update
    @meeting.update_attributes(meeting_params)
    
    if @meeting.save
      flash[:success] = "Meeting updated successfully."
      redirect_to meeting_path(@meeting)
    else
      flash[:error] = "Meeting has not been updated: " +  @meeting.errors.full_messages.join(". ") + "."
      render :edit
    end
  end

  def destroy
    if @meeting.destroy
      flash[:success] = "Meeting deleted successfully."
      redirect_to meeting_path(@meeting)
    else
      flash[:error] = "Meeting has not been deleted: " +  @meeting.errors.full_messages.join(". ") + "."
      redirect_to meeting_path(@meeting)
    end
  end

  private

  def get_meeting
    @meeting = Meeting.find(params[:id])
  end

  def meeting_params
    params.require(:meeting).permit(:name,:date,:team_ids, :feature_request_ids, :time, :agenda, :location, :status)
  end

end
