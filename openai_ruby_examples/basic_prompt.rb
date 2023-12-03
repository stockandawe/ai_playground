# frozen_string_literal: true

# !/usr/bin/env ruby

require "byebug"
require 'dotenv/load'
require "openai"


@client = OpenAI::Client.new(access_token: ENV["OPENAI_SK"])

# Create a function to interact with the API
def generate_text(prompt, temperature=0.7, max_tokens=100, top_p=1.0)
  begin
    response = @client.chat(
      parameters: {
          model: "gpt-3.5-turbo", # Required.
          messages: [{ role: "user", content: prompt}], # Required.
          temperature: 0.7,
      })    

    return response.dig("choices", 0, "message", "content")

  rescue StandardError => e
    puts "Error generating text: #{e.message}"
    return nil
  end
end

# Use the function with a clear and specific prompt
prompt = "Translate the following English text to French: 'Hello, how are you?'"
generated_text = generate_text(prompt)

puts "Generated text: #{generated_text}"