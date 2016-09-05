class SequencesController < ApplicationController

  before_filter :signed_in_user

  def index   

    respond_to do |format|

      format.html do
        @sequences = Sequence.includes(:features, :sequence_versions).all
      end

      format.json do 
        render json: Sequence.includes(:sequence_versions).all
                             .as_json(include: [:features, :sequence_versions])
      end

    end    

  end

  def show

    respond_to do |format|

      format.html

      format.json do
        render json: Sequence.includes(:features, :sequence_versions)
                             .find(params[:id])
                             .as_json(include: [:features, :sequence_versions])  
      end

    end

  end

end