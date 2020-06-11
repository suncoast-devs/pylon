class RecordingsController < ApplicationController
  def create
    # For now just log what we receive
    log(request.raw_post)
  end
end
