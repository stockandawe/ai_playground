# frozen_string_literal: true

# !/usr/bin/env ruby

require "byebug"
require 'dotenv/load'
require "anthropic"


@client = Anthropic::Client.new(access_token: ENV[ANTHROPIC_ACCESS_TOKEN])

# Create a function to interact with the API
def generate_text(prompt, temperature=0.7, max_tokens=100, top_p=1.0)
  begin
    response = @client.complete(
      parameters: {
          model: "claude-2",
          prompt: prompt,
          max_tokens_to_sample: 5
      })
    return response["completion"]    

  rescue StandardError => e
    puts "Error generating text: #{e.message}"
    return nil
  end
end

# Use the function with a clear and specific prompt
prompt = "Translate the following English text to French: 'Hello, how are you?'"
generated_text = generate_text(prompt)

puts "Generated text: #{generated_text}"