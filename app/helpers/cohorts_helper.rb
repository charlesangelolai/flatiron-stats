module CohortsHelper
  def status_color(status)
    if status == "pending"
      "bg-warning text-dark"
    else
      "bg-success"
    end
  end
end
