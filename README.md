# Hannah

**TODO:**
* Convert to Slack Bot
* Update Data structure of Personalities
* Improve Speech processing (eg, best sentence choosing + pronoun switching)

## Example
Hi. What would you like to talk about?

I don't know

>> Are you always so indecisive?

Yes, usually

>> Great.

I'm sorry!

>> There's no need to apologize.

So why can't you talk to me properly?

>> Do you want me to talk to you properly?

Yes

>> At least you're positive about something!

I don't know about that

>> Are you always so indecisive?

Woe is me, why can't I make decisions?


>> Do you want to make decisions?


Everyone does


>> You think everyone does?

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `hannah` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:hannah, "~> 0.1.0"}]
    end
    ```

  2. Ensure `hannah` is started before your application:

    ```elixir
    def application do
      [applications: [:hannah]]
    end
    ```

