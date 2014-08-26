class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :check_user, only: [:edit, :update, :destroy]
  #before_action :start_page, only: [:show, :edit, :update, :destroy]
  
  
  # GET /words
  # GET /words.json
    def ask
      @words = current_user.words.order("random()").first(5)      
        @words.sample(1).each do |as|
          @ask= as.word_a 
        end       
    end
  
  # GET /words
  # GET /words.json
  def index
    @words = Word.where(user: current_user)
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    @word = Word.new
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words
  # POST /words.json
  def create
    @word = Word.new(word_params)
    @word.user_id = current_user.id
    
    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        format.json { render action: 'show', status: :created, location: @word }
      else
        format.html { render action: 'new' }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      format.html { redirect_to words_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
        @word = Word.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.require(:word).permit(:word_a, :word_b, :know, :user_id)
    end
    
    def check_user
	if current_user != @word.user
	redirect_to words_path, alert: "This is not yours"
	end
    end
    
    def start_page
      if user_signed_in?
        redirect_to words_path
      else
        redirect_to root_url
      end
    end
    
    def check
      @quiz = Quiz.find(params[:id])
      if params[:guess] == @quiz.correct_answer
        #...
      else
        #...
      end
    end
    
end
