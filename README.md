# Hannah
A rudimentary chat bot written in Elixir. THis was based and adapted off of a tutorial in the book Beginning Ruby by Peter Cooper

**TODO:**
* Convert to Slack Bot/Make an executable
* Update Data structure of Personalities
* Improve Speech processing (eg, best sentence choosing + pronoun switching)

## Usage

Run `iex -S mix`

Converse with Hannah by via the Server module, eg.(`Hannah.Server.converse("Hello!")`) ...This isn't great so will improve the interface at a later date

## Example
>> Hi. What would you like to talk about?  (Hannah)

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

