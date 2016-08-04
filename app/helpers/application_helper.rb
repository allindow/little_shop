module ApplicationHelper
  def new_user_path?
    request.path == new_user_path || formatted_referrer == new_user_path
  end

  def admin_edit?
    current_admin? && request.path == edit_user_path(current_user)
  end

  private

  def formatted_referrer
    '/' + request.referrer.split('/')[-2..-1].join('/') if request.referrer
  end
end
