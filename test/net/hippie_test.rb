require 'test_helper'

class HippieTest < Minitest::Test
  def teardown
    Net::Hippie.verify_mode = OpenSSL::SSL::VERIFY_PEER
  end

  def test_that_it_has_a_version_number
    refute_nil ::Net::Hippie::VERSION
  end

  def test_it_does_something_useful
    assert true
  end

  def test_it_has_a_default_verify_mode
    assert Net::Hippie.verify_mode == OpenSSL::SSL::VERIFY_PEER
  end

  def test_it_can_customize_the_verify_mode
    Net::Hippie.verify_mode = OpenSSL::SSL::VERIFY_NONE
    assert Net::Hippie.verify_mode == OpenSSL::SSL::VERIFY_NONE
  end

  def test_get_with_retry
    uri = URI.parse('https://www.example.org/api/scim/v2/schemas')
    WebMock.stub_request(:get, uri.to_s)
      .to_timeout.then
      .to_timeout.then
      .to_timeout.then
      .to_return(status: 200, body: { 'success' => 'true' }.to_json)
    response = Net::Hippie.get(uri)
    refute_nil response
    assert_equal Net::HTTPOK, response.class
    assert_equal JSON.parse(response.body)['success'], 'true'
  end
end
