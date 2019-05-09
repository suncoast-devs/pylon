class PylonBot < SlackRubyBot::Bot
  def self.client
    @client ||= Slack::Web::Client.new
  end

  def self.message(person, text)
    unless person.slack_user
      return { "ok" => false }
    end

    message = { text: text }

    im = client.im_open(user: person.slack_user)
    channel = im["channel"]["id"]

    client.chat_postMessage({ text: text, channel: channel, as_user: true })
  end

  command "register" do |client, data, match|
    dm = direct_message?(data)

    unless dm
      client.say(text: "This command works on in a direct message", channel: data.channel)
      return
    end

    invite_code = data.text[/register (.*)/, 1]

    unless invite_code
      client.say(text: "Please provide an invitation code", channel: data.channel)
      return
    end

    person = Person.find_by(slack_invite_code: invite_code)

    unless person
      client.say(text: "Sorry, this invite code was not found", channel: data.channel)
      return
    end

    if person.update(slack_user: data.user, slack_invite_code: nil)
      client.say(text: "You have been registered with Pylon", channel: data.channel)
    else
      client.say(text: "Sorry, could not register you with Pylon", channel: data.channel)
    end
  end
end
