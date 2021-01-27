class SurveysController < ApplicationController
  def index
    @surveys = Survey.all
  end
end
