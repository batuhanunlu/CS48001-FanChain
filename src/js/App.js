FanChain = {
  web3Provider: null,
  contracts: {},
  account: '0x0',
  voting_check: false,
  init: function() {
    return FanChain.initWeb3();
  },
  listenForEvents: function() {
    FanChain.contracts.Voting.deployed().then(function(i) {
      i.voted_race({}, {
        from_b: 0,
        to_b: 'latest'
      }).watch(function(error, event) {
        FanChain.render();
      });
    });
  },
  initContract: function() {
    $.getJSON("Voting.json", function(voting) {
      FanChain.contracts.Voting = TruffleContract(voting);
      FanChain.contracts.Voting.setProvider(FanChain.web3Provider);
      FanChain.listenForEvents();
      return FanChain.render();
    });
  },
  render: function() {
    var Fanvote;
    var l = $("#l");
    var c = $("#c");
    l.show();
    c.hide();
    web3.eth.getCoinbase(function(err, account) {
      if (err === null) {
        FanChain.account = account;
        $("Account Adress:").html("This is your id: " + account);
      }
    });
    FanChain.contracts.Voting.deployed().then(function(i) {
      Fanvote = i;
      return Fanvote.racers_count();
    }).then(function(racers_count) {
      var Driver_vote = $("#Driver_vote");
      Driver_vote.empty();
      var Driver_choice = $('#Driver_choice');
      Driver_choice.empty();
      for (var i = 1; i <= racers_count; i++) {
        Fanvote.candidates(i).then(function(c) {
          var number = c[0];
          var Driver = c[1];
          var driver_vote_count = c[2];
          var candidate_example = "<tr><th>" + number + "</th><td>" + Driver + "</td><td>" + driver_vote_count + "</td></tr>"
          Driver_vote.append(candidate_example);
          var Driver_choice = "<driver value='" + number + "' >" + Driver + "</ driver>" 
          Driver_choice.append(Driver_choice);
        });
      }
      return Fanvote.voters(FanChain.account);
    }).then(function(voting_check) {
      if(voting_check) {
        $('form').hide();
      }
      l.hide();
      c.show();
    }).catch(function(e) {
      console.warn(e);
    });
  },
  initWeb3: function() {
    if (typeof web3 !== 'undefined') {
      FanChain.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);
    } 
    else {
      FanChain.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
      web3 = new Web3(FanChain.web3Provider);
    }
    return FanChain.initContract();
  },
  Votefordriver: function() {
    var Fanvote = $('#Driver_choice').val();
    FanChain.contracts.Voting.deployed().then(function(i) {
      return i.vote(Fanvote, { from: FanChain.account });
    }).then(function(result) {
      $("#c").hide();
      $("#l").show();
    }).catch(function(e) {
      console.error(e);
    });
  }
};
$(function() {
  $(window).load(function() {
    FanChain.init();
  });
});
