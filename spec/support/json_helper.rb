# frozen_string_literal: true

def json_response
  Oj.load(response.body, symbol_keys: true)
end
