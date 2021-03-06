 class SubjectsController < ApplicationController

  layout 'admin'
  before_action :set_subject_count, :only => [:new, :create, :edit, :update]
  
  def index
    logger.debug("******Testing the logger. ******")
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => 'Default'})
    
  end

  def create
    # Instantiate a new object using form parameters
    @subject = Subject.new(subject_params)
    # Save the object
    if @subject.save
    # If save succeeds, redirect to the show action
     
      redirect_to(subjects_path(@subject))
    else
    # If save fails, redisplay the form so user can fix problems
    @subject_count = Subject.count + 1
    render('new')
    end

  end

  def edit
    @subject = Subject.find(params[:id])
    
  end

  def update
    @subject = Subject.find(params[:id])
    # finde the object
    if @subject.update_attributes(subject_params)
    # If Update succeeds, redirect to the show action
      flash[:notice] = "Subject updated successfully."  
      redirect_to(subject_path(@subject))
    else
    # If save fails, redisplay the form so user can fix problems
    @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])

  end

  def destroy
    @subject = Subject.find(params[:id])
    @subject.destroy
    flash[:notice] = "Subject '#{@subject.name}' destroyed successfully."    
    redirect_to(subjects_path)
  end

  private

  def subject_params
    params.require(:subject).permit(:name, :position, :visible, :created_at)
  end

  def set_subject_count
    @subject_count = Subject.count
    if params[:actions] == 'new' || params[:actions] == 'create'
      @subject_count = Subject.count + 1
    end
  end

  
end
