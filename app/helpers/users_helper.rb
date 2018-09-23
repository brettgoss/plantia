module UsersHelper
  def plant_count
    count = @user.plants.all.count
    if count === 1
      "#{count} plant"
    else
      "#{count} plants"
    end
  end
end
