module UsersHelper
  def plant_count
    count = @user.plants.all.count
    if count === 1
      "#{count} plant"
    else
      "#{count} plants"
    end
  end

  def subscriptions_count
    count = @user.subscriptions.all.count
    if count === 1
      "#{count} device subscribed to notifications"
    else
      "#{count} devices subscribed to notifications"
    end
  end
end
