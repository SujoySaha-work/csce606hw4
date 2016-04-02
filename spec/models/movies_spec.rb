require 'spec_helper'

describe Movie do
  describe '#Similar Director' do
    context "Happy path: Non-empty director field " do
      before(:each) do
        @movie5 = FactoryGirl.create(:movie, title: "Alien", director: "Ridley Scott", rating: "R", release_date: "1979-05-25")
        @movie5.save
        @movie4 = FactoryGirl.create(:movie, title: "Star Wars", director: 'George Lucas', release_date: "1977-05-25")
        @movie3 = FactoryGirl.create(:movie, title:  "Blade Runner", rating:  "PG", release_date: "1982-06-25", director:  "Ridley Scott" )
      end

      it 'with director field non-empty' do 
        expect(@movie5.director).not_to be_nil
      end

      it 'finds the director of the movie' do
         
        Movie.find_all_by_director(@movie5).each do |m|
            m.director.should eq("Ridley Scott")
            m.director.should_not eq("George Lucas")
        end
        Movie.find_all_by_director(@movie4).each do |m|
            m.director.should_not eq("Ridley Scott")
            m.director.should eq("George Lucas")
        end
        
      end
      
    end

    context "Sad path: the director field is empty" do
      it 'find the director field is empty' do
        @movie6 = FactoryGirl.create(:movie, title: "THX-1138", director: nil)
         Movie.find_all_by_director(@movie6).should be_empty
      
      end
    end
  end
  
  describe "#all_ratings" do 
    it 'should return array ["G", "PG", "PG-13", "NC-17", "R"]' do
      Movie.stub(:all_ratings).and_return(["G", "PG", "PG-13", "NC-17", "R"]) 
      expect(Movie.all_ratings).to eq(["G", "PG", "PG-13", "NC-17", "R"])
    end
  end
end

#require 'spec_helper'

RSpec.describe MoviesController, :type => :controller do

  

  describe 'UPDATE DIRECTOR' do
   
    it 'should call update_attributes and redirect' do
      @mov1 = double('Movie', :title => 'Hunger Games', :director => 'Nora', :id => '21')
      allow(Movie).to receive(:find).with('21').and_return(@mov1)
      expect(@mov1).to receive(:update_attributes!).and_return(true)
      put :update, {:id => '21', :movie => @mov1}
      expect(response).to redirect_to(movie_path(@mov1))
    end
  end
  
  describe 'HOMEPAGE' do
    it 'render HOMEPAGE' do
      get :index
      expect(response).to render_template('index')
    end
  end
  
  describe 'CREATE/DELETE' do
    it 'DELETE' do
      movie = double('Movie', :title => 'Hunger Games 2', :director => 'Nora', :id => '23')
      allow(Movie).to receive(:find).with('23').and_return(movie)
      expect(movie).to receive(:destroy)
      delete :destroy, {:id => '23'}
    end
    it 'CREATE' do
      movie = double('Movie', :title => 'Hunger Games', :director => 'Nora', :id => '2')
      allow(Movie).to receive(:create).and_return(movie)
      post :create, {:id => '2'}
    end
    
  end


end

