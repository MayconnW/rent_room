class WelcomeController < UserDefaultController

  def index
    
    if params[:username]
      @user = User.find_by url: params[:username]
    else
      @user = current_user
    end
    
    set_default_values_to_user
    temp = @user.projects.where(head: true).order(:order)
    if temp.size > 0
      @projectMain = temp[0]
    else
      @projectMain = nil
    end
    @projectsHead = []
    temp.each do |row|
      if row.id != @projectMain.id
        @projectsHead << row
      end
    end
    temp = @user.projects.where(head: false).order(:order)
    @projectsSecondary = []
    temp.each do |row|
      @projectsSecondary << row
    end
    
    @works = @user.works.order(begin_date: :desc)
    @skills = @user.skills.order(:id)
    @testimonials = @user.testimonials.order(id: :desc)
    @courses = @user.courses.order(begin_date: :desc)
    @idioms = @user.idioms.order(level: :desc)
  end
  
  private 
  def set_default_values_to_user
    if @user.city == nil
      @user.city = City.new
    end
    if @user.state == nil
      @user.state = State.new
    end
  end
end
