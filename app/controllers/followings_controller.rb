class FollowingsController < ApplicationController

  before_filter :check_access
  layout        :determine_layout

  def create

    followed_user = User.find( params[ :followed_user_id ] )
    following = Following.new( :followed_user_id  => followed_user.id,
                               :following_user_id => current_user.id )
    following.save

    FollowingsMailer.follow_request( following ).deliver

    flash[:notice] = "Your follow request has been sent to #{followed_user.name}."

    redirect_to user_following_path( current_user )

  end

  def edit

    following = Following.find( params[:id], 
                                :include => [:followed_user, :following_user] )
    
    if following.include? current_user
      render :locals => { :following => following }
    else
      redirect_to user_followers_path( current_user )
    end

  end

  def update
    
    following = Following.find params[:id]

    if    params[ :approve ] and following.approver? current_user
      following.approve!
      flash[:notice] = "#{following.following_user.name} is now following you."
    elsif params[ :ignore ]  and following.approver? current_user
      following.ignore!
      flash[:notice] = "You've ignored #{following.following_user.name}'s follow request."
    elsif params[ :cancel ]  and following.requester? current_user
      following.cancel!
      flash[:notice] = "Your follow request to #{following.followed_user.name} is now canceled."
    end

    redirect_to user_followers_path( current_user )

  end

  def followers
    @user = User.find params[:user_id] 
  end

  def following
    @user = User.find params[:user_id]
  end

  private

  def determine_layout

    case action_name
    when 'followers', 'following'
      'users'
    else
      'application'
    end

  end

end
