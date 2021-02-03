module ApplicationHelper
  def is_admin?
    current_user.role_id == 1
  end

  def is_instructor?
    current_user.role_id == 2
  end

  def redirect_if_no_cohort
    unless current_user.cohort_id
      redirect_to edit_user_registration_path
    end
  end

  def format_date(year, month, day)
    year = (year.to_i % 100).to_s
    month.prepend("0") unless month.length > 1
    day.prepend("0") unless day.length > 1
    full_date = month + day + year
    
    full_date
  end

  def format_cohort_name(date, program, time)
    @COHORT_PROGRAMS = {
      "Software Engineering" => "seng",
      "Data Science" => "dsci",
      "Cyber Security" => "csec"
    }
    
    @COHORT_TIME = {
      "Full-Time" => "ft",
      "Part-Time" => "pt"
    }

    cohort_name = "#{@COHORT_PROGRAMS[program]}-#{@COHORT_TIME[time]}-#{date}"
    
    cohort_name
  end
end
