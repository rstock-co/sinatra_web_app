require_relative 'test_helper'

class PalindromeAppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get '/'
    assert last_response.ok?
    assert doc(last_response).at_css('h1')
    assert_equal "Learn Enough Ruby Sample App | Home",
      doc(last_response).at_css('title').content
    assert doc(last_response).at_css('nav')
  end

  def test_about
    get '/about'
    assert last_response.ok?
    assert doc(last_response).at_css('h1')
    assert_equal "Learn Enough Ruby Sample App | About",
      doc(last_response).at_css('title').content
  end

  def test_palindrome
    get '/palindrome'
    assert last_response.ok?
    assert doc(last_response).at_css('h1')
    assert_equal "Learn Enough Ruby Sample App | Palindrome Detector",
      doc(last_response).at_css('title').content
  end

  def test_form_presence
    get '/palindrome'
    assert doc(last_response).at_css('form')
  end

  def test_non_palindrome_submission
    post '/check', { phrase: "Not a palindrome" }
    assert_includes doc(last_response).at_css('p').content, "isn't a palindrome!"
  end
end
