# see http://mislav.uniqpath.com/poignant-guide/book/chapter-5.html
{Limbo} = require('limbo')
{uniq, intersection} = require('underscore')

randInt = (max) -> Math.floor(max * Math.random())

exports.LotteryTicket = LotteryTicket = Limbo (ticket) ->
  MAX = 25
  MIN = 1
  ticket.init = (picks...) ->
    @picks = picks
    @purchased = new Date
    if uniq(picks).length isnt 3
      throw new Error("three unique numbers must be picked.")
    
    for pick in picks
      unless pick in [MIN..MAX]
        throw new Error("all three picks must be between #{MIN} and #{MAX}.")

  ticket.score = (winner) -> intersection(@picks, winner.picks).length

  randomPick = -> MIN + randInt(MAX)
  @random = ->
    try
      @(randomPick(), randomPick(), randomPick())
    catch e
      @random()

LotteryDraw = ( ->
  tickets = {}

  buy: (customer, tickets...) ->
    tickets[customer] ?= []
    tickets[customer] = tickets[customer].concat(tickets)

  play: ->
    draw = LotteryTicket.random()
    winners = {}
    for buyer, ticketList in tickets
      for ticket in ticketList
        score = ticket.score(draw)
        (winners[buyer] ?= []).push([ticket, score]) unless score is 0

    tickets = {}
    winners
)()

# buy some tickets
LotteryDraw.buy 'Gram-yol',
  LotteryTicket(25, 14, 33), LotteryTicket(12, 11, 29)
LotteryDraw.buy 'Tarker-azain', LotteryTicket(13, 15, 29)
LotteryDraw.buy 'Bramlor-exxon', LotteryTicket(2, 6, 14)

# play and report
for winner, ticket in LotteryDraw.play()
  console.log("#{winner} won on #{tickets.length} ticket(s)!")
  for ticket, score in ticket
    console.log("\t#{ticket.picks.join(', ')}: #{score}
