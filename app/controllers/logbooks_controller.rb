
class LogbooksController < ApplicationController
  # GET /logbooks
  # GET /logbooks.json
  def index
    @logbooks = Logbook.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @logbooks }
    end
  end

  # GET /logbooks/1
  # GET /logbooks/1.json
  def show
    @logbook = Logbook.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @logbook }
    end
  end

  # GET /logbooks/new
  # GET /logbooks/new.json
  def new
    @logbook = Logbook.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @logbook }
    end
  end

  # GET /logbooks/1/edit
  def edit
    @logbook = Logbook.find(params[:id])
  end

  # POST /logbooks
  # POST /logbooks.json
  def create
    @logbook = Logbook.new(params[:logbook])

    respond_to do |format|
      if @logbook.save
        format.html { redirect_to @logbook, notice: 'Logbook was successfully created.' }
        format.json { render json: @logbook, status: :created, location: @logbook }
      else
        format.html { render action: "new" }
        format.json { render json: @logbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /logbooks/1
  # PUT /logbooks/1.json
  def update
    @logbook = Logbook.find(params[:id])

    respond_to do |format|
      if @logbook.update_attributes(params[:logbook])
        format.html { redirect_to @logbook, notice: 'Logbook was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @logbook.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /logbooks/1
  # DELETE /logbooks/1.json
  def destroy
    @logbook = Logbook.find(params[:id])
    @logbook.destroy

    respond_to do |format|
      format.html { redirect_to logbooks_url }
      format.json { head :no_content }
    end
  end
end
