import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:neopop/widgets/buttons/neopop_button/neopop_button.dart';
import 'package:serenity/constants/const.dart';

class ShlokaScreen extends StatefulWidget {
  @override
  _ShlokaScreenState createState() => _ShlokaScreenState();
}

class _ShlokaScreenState extends State<ShlokaScreen> {
  final List<String> shlokas = [
    "You have a right to perform your prescribed duties, but you are not entitled to the fruits of your actions. - Bhagavad Gita 2.47",
    "For the soul, there is neither birth nor death at any time. He has not come into being, does not come into being, and will not come into being. He is unborn, eternal, ever-existing, and primeval. He is not slain when the body is slain. - Bhagavad Gita 2.20",
    "The soul can never be cut to pieces by any weapon, nor burned by fire, nor moistened by water, nor withered by the wind. - Bhagavad Gita 2.23",
    "Just as a person gives up old garments and puts on new ones, similarly, the soul accepts new material bodies, giving up the old and useless ones. - Bhagavad Gita 2.22",
    "One who sees inaction in action, and action in inaction, is intelligent among men. - Bhagavad Gita 4.18",
    "The mind acts like an enemy for those who do not control it. - Bhagavad Gita 6.6",
    "The mind is restless and difficult to restrain, but it is subdued by practice. - Bhagavad Gita 6.35",
    "One who has control over the mind is tranquil in heat and cold, in pleasure and pain, and in honor and dishonor, and is ever steadfast with the Supreme Self. - Bhagavad Gita 6.7",
    "Wherever there is Krishna, the master of yoga, and wherever there is Arjuna, the supreme archer, there also will surely be victory, prosperity, and sound morality. - Bhagavad Gita 18.78",
    "Neither this world, nor the world beyond, nor happiness can be found by anyone who always doubts. - Bhagavad Gita 4.40",
    "A gift given out of duty, without expectation of return, at the proper time and place, and to a worthy person is considered to be in the mode of goodness. - Bhagavad Gita 17.20",
    "As a person surrenders unto Me, I reciprocate accordingly. Everyone follows My path in all respects, O son of Prtha. - Bhagavad Gita 4.11",
    "Whatever action is performed by a great man, common men follow. And whatever standards he sets by exemplary acts, all the world pursues. - Bhagavad Gita 3.21",
    "One who does good, My friend, is never overcome by evil. - Bhagavad Gita 6.40",
    "He who is free from the desire for respect, and is free from desire, is fit for liberation. - Bhagavad Gita 18.53",
    "When a person responds to the needs of the senses, then bondage arises. When he withdraws from the senses, then liberation is achieved. - Bhagavad Gita 2.64",
    "In this world, there is nothing so sublime and pure as transcendental knowledge. Such knowledge is the mature fruit of all mysticism. - Bhagavad Gita 4.38",
    "But those who worship Me with devotion, meditating on My transcendental form—to them I carry what they lack, and I preserve what they have. - Bhagavad Gita 9.22",
    "One should uplift oneself by one's own mind, and not degrade oneself. The mind is the friend of the conditioned soul, and his enemy as well. - Bhagavad Gita 6.5",
    "Those who are wise lament neither for the living nor the dead. - Bhagavad Gita 2.11",
    "The nonpermanent appearance of happiness and distress, and their disappearance in due course, are like the appearance and disappearance of winter and summer seasons. - Bhagavad Gita 2.14",
    "A person is said to be elevated in yoga when, having renounced all material desires, he neither acts for sense gratification nor engages in fruitive activities. - Bhagavad Gita 6.4",
    "Just as a lamp in a windless place does not waver, so is the transcendentalist, whose mind is controlled, and who practices meditation on the Self. - Bhagavad Gita 6.19",
    "I am the beginning, the middle, and the end of all creations. - Bhagavad Gita 10.20",
    "One who sees everything in relation to the Supreme Lord, and sees the Supreme Lord within everything, never hates anything nor any being. - Bhagavad Gita 6.29",
    "The true yogi observes Me in all beings and also sees every being in Me. Indeed, the self-realized person sees Me everywhere. - Bhagavad Gita 6.30",
    "I am seated in everyone's heart, and from Me come remembrance, knowledge, and forgetfulness. - Bhagavad Gita 15.15",
    "One who is beyond duality and doubt, whose mind is engaged within, who is always busy working for the welfare of all sentient beings, achieves liberation in the Supreme. - Bhagavad Gita 5.25",
    "He who has no attachments can truly love others, for his love is pure and divine. - Bhagavad Gita 15.5",
    "But those who worship Me with exclusive devotion, meditating on My transcendental form—I carry what they lack and preserve what they have. - Bhagavad Gita 9.22",
    "My true being is not visible to all. Enveloped by My yoga-maya, I am not manifest to everyone. - Bhagavad Gita 7.25",
    "Whenever dharma declines and the purpose of life is forgotten, I manifest myself on earth. - Bhagavad Gita 4.7",
    "Work done as a sacrifice for the Supreme has to be performed, otherwise work binds one to this material world. - Bhagavad Gita 3.9",
    "To those who are constantly devoted and who worship Me with love, I give the understanding by which they can come to Me. - Bhagavad Gita 10.10",
    "All this work cannot bind Me. I am ever detached from all these material actions, seated as though neutral. - Bhagavad Gita 9.9",
    "By Me, in My unmanifested form, this entire universe is pervaded. - Bhagavad Gita 9.4",
    "The embodied soul is eternal, unbreakable, and immutable, and can be neither destroyed nor slain. - Bhagavad Gita 2.24",
    "If you want to see the brave and the bold, look to those who can return love for hatred. - Bhagavad Gita 5.29",
    "Perform your duty without attachment, for by doing so, one attains the Supreme. - Bhagavad Gita 3.19",
    "One who controls the mind, and is free from all desires, attains peace. - Bhagavad Gita 5.26",
    "Even if you are considered to be the most sinful of all sinners, when you are situated in the boat of transcendental knowledge, you will be able to cross over the ocean of miseries. - Bhagavad Gita 4.36",
    "I am the source of all spiritual and material worlds. Everything emanates from Me. - Bhagavad Gita 10.8",
    "The mind is its own friend as well as its own enemy. - Bhagavad Gita 6.5",
    "The wise work without attachment, for the welfare of the world. - Bhagavad Gita 3.25",
    "To abstain from work is impossible, even for a moment. - Bhagavad Gita 3.5",
    "I am time, the great destroyer of the world. - Bhagavad Gita 11.32",
    "As they surrender unto Me, I reward them accordingly. - Bhagavad Gita 4.11",
    "Out of compassion for them, I, dwelling in their hearts, destroy with the shining lamp of knowledge the darkness born of ignorance. - Bhagavad Gita 10.11",
    "A person is wise when they remain calm and composed, both in joy and in sorrow. - Bhagavad Gita 2.15",
    "I am the ritual, the sacrifice, the offering to ancestors, the healing herb, and the transcendental chant. - Bhagavad Gita 9.16",
    "Those who know the transcendental nature of My appearance and activities do not, upon leaving the body, take their birth again in this material world. - Bhagavad Gita 4.9",
    "He who restrains his senses and fixes his consciousness upon Me is known as a man of steady intelligence. - Bhagavad Gita 2.61",
    "A learned person does not differentiate between the learned and gentle brahmana, a cow, an elephant, a dog, or a dog-eater. - Bhagavad Gita 5.18",
    "All living beings are but part of the Supreme, or, in other words, the Supreme is distributed among all living beings. - Bhagavad Gita 10.20",
    "When a person gives up all material desires, he finds peace. - Bhagavad Gita 2.71",
    "One who is not disturbed by happiness and distress, and is steady in both, is certainly eligible for liberation. - Bhagavad Gita 2.15",
    "The wise man lets go of all results, whether good or bad, and is focused on the action alone. - Bhagavad Gita 2.50",
    "He who finds happiness within, joy within, and also light within, that yogi attains the eternal bliss of the Brahman. - Bhagavad Gita 5.24",
    "I am the goal, the upholder, the master, the witness, the abode, the refuge, the dearest friend, the creation and the annihilation, the basis of all things, the resting place and the eternal seed. - Bhagavad Gita 9.18",
    "One who sees inaction in action, and action in inaction, is intelligent among men. - Bhagavad Gita 4.18",
    "Even the wise are confused about what is action and what is inaction. Therefore, I will explain to you what action is, knowing which you will be liberated from all misfortune. - Bhagavad Gita 4.16",
    "A person can attain peace by acting with a pure mind, self-control, and by constantly practicing forgiveness and humility. - Bhagavad Gita 18.63",
    "Deluded by desires, men run after material wealth, power, and the ephemeral pleasures of life. - Bhagavad Gita 2.71",
    "A true yogi is one who sees God in all beings and treats everyone equally. - Bhagavad Gita 6.32",
    "Those who are devoid of desire for the fruits of action, always content, and independent, do not perform any action although engaged in all kinds of undertakings. - Bhagavad Gita 4.20",
    "I am the origin of all; everything emanates from Me. The wise, who know this, worship Me with all their heart. - Bhagavad Gita 10.8",
    "They are forever free who renounce all selfish desires and reach the state of freedom from all desires, entering a state of bliss. - Bhagavad Gita 6.27",
    "By performing one’s own duty imperfectly rather than doing another’s duty perfectly, one progresses spiritually. - Bhagavad Gita 3.35",
    "In the modes of goodness, the soul finds illumination; in passion, it finds a yearning for gain; in ignorance, it finds darkness and delusion. - Bhagavad Gita 14.11",
    "Whatsoever form of me that any devotee seeks with faith—that same I make firm and lasting for them. - Bhagavad Gita 7.21",
    "When one’s intelligence is undisturbed, one is not affected by the senses or their fluctuations. - Bhagavad Gita 2.70",
    "I am the father of this world, the mother, the support, the grandsire. - Bhagavad Gita 9.17",
    "As fire is covered by smoke, a mirror by dust, and an embryo by the womb, similarly, knowledge is covered by different desires. - Bhagavad Gita 3.38",
    "In the same manner that a well is no longer of use to a person who has found a river, so all scriptures are of no use to the one who has realized God. - Bhagavad Gita 2.46",
    "Those who have conquered their senses, and who fix their consciousness upon Me, are steady and composed in their intelligence. - Bhagavad Gita 2.61",
    "The Supreme Lord is situated in everyone's heart, O Arjuna, and is directing the wanderings of all living entities. - Bhagavad Gita 18.61",
    "He who knows himself to be the soul, and not the body, truly knows. - Bhagavad Gita 2.30",
    "Arjuna, those who meditate upon Me as the Supreme, without deviation, realize Me. - Bhagavad Gita 12.2",
    "When a person gives up all desires for sense gratification, which arise from mental concoction, he finds peace. - Bhagavad Gita 2.71",
    "Only one who is fearless, tolerant, forgiving, pure-hearted, without attachment, and without envy can become My devotee. - Bhagavad Gita 12.13",
    "An intelligent person does not take part in the sources of misery, which are due to contact with the material senses. - Bhagavad Gita 5.22",
    "The uncontrolled mind is the greatest enemy of the soul. - Bhagavad Gita 6.6",
    "One attains success by worshipping God as prescribed in their specific scripture. - Bhagavad Gita 9.22",
    "I am the transcendental, eternal consciousness, and I am also the supreme reality beyond the reach of the senses. - Bhagavad Gita 8.20",
    "The real renouncer is not one who refrains from action but one who does everything with detachment. - Bhagavad Gita 6.1",
    "A yogi sees himself in the hearts of all beings and sees all beings in his own heart. - Bhagavad Gita 6.29",
    "Actions are always performed by the modes of material nature, but a person who has attained the truth sees that the soul does nothing. - Bhagavad Gita 13.29",
    "Arjuna, in this world there is nothing so purifying as knowledge. One who is perfected in yoga discovers this truth within his soul in due course of time. - Bhagavad Gita 4.38",
    "I am the fragrance of the earth, the brightness in fire, the life in all beings, and the austerity in ascetics. - Bhagavad Gita 7.9",
    "The supreme duty of a human is to develop love for the Divine. - Bhagavad Gita 8.22",
    "The senses are higher than the body, the mind is higher than the senses, the intelligence is higher than the mind, and the soul is higher than the intelligence. - Bhagavad Gita 3.42",
    "To him who has conquered the mind, the mind is the best of friends; but for one who has failed to do so, his mind will remain the greatest enemy. - Bhagavad Gita 6.6",
    "Arjuna, whatever you do, whatever you eat, whatever you offer or give, and whatever austerities you perform—do that as an offering unto Me. - Bhagavad Gita 9.27",
    "I am the time, the mighty force, destined to destroy the universe. - Bhagavad Gita 11.32",
    "One attains to peace and harmony by focusing on the eternal Self within. - Bhagavad Gita 6.15",
    "You must perform your duty, for action is superior to inaction. - Bhagavad Gita 3.8",
    "Just as fire is covered by smoke, knowledge is covered by desire. - Bhagavad Gita 3.38",
    "You should thus take up the sword of knowledge and cut down this tree of attachment. - Bhagavad Gita 15.3",
    "Arjuna, when a person meditates upon Me as Supreme, without deviation, I bring what he lacks and preserve what he has. - Bhagavad Gita 9.22",
    "I am the taste in water, the light of the sun and the moon, the sound in ether, and the ability in man. - Bhagavad Gita 7.8",
    "A person who does not hate anyone, who is friendly and compassionate, who is free from possessiveness and ego, who is peaceful in pain and pleasure, and who is forgiving, is dear to Me. - Bhagavad Gita 12.13",
    "One who does not rejoice in happiness or lament in distress, who is beyond good and evil, is very dear to Me. - Bhagavad Gita 12.17",
    "A yogi who is satisfied by knowledge and wisdom, who remains unshaken in adversity, who has conquered his senses, and for whom a lump of earth, stone, and gold are the same, is said to be in yoga. - Bhagavad Gita 6.8",
    "In this world there is nothing as purifying as knowledge. - Bhagavad Gita 4.38",
    "As a flame does not flicker in a windless place, so is the mind of a yogi who has conquered his mind. - Bhagavad Gita 6.19",
    "When a person restrains his senses and fixes his consciousness upon Me, he is known as a man of steady intelligence. - Bhagavad Gita 2.61",
    "To those who are constantly devoted to serving Me with love, I give the understanding by which they can come to Me. - Bhagavad Gita 10.10",
    "There is no purifier in this world like knowledge. - Bhagavad Gita 4.38",
    "All beings are born into delusion, overcome by the dualities of desire and hate. - Bhagavad Gita 7.27",
    "Know that all beautiful, glorious, and mighty creations spring from but a spark of My splendor. - Bhagavad Gita 10.41",
    "As the blazing fire reduces wood to ashes, so does the fire of knowledge burn to ashes all karma. - Bhagavad Gita 4.37",
    // Add more as needed up to 200
  ];

  String currentShloka = "";

  @override
  void initState() {
    super.initState();
    _getRandomShloka(); // Display a random Shloka on launch
  }

  void _getRandomShloka() {
    final randomIndex = Random().nextInt(shlokas.length);
    setState(() {
      currentShloka = shlokas[randomIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Container(
                height: 200,
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text("Read a Shlok",
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: Colors.white38,
                              )),
                          const SizedBox(height: 10),
                          Text(
                              "Meaningful and motivational quotations can help spark inspiration and create a sense of purpose.",
                              style: GoogleFonts.libreBaskerville(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 5,
                color: accentColor,
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Bhagavad Gita',
                      style: GoogleFonts.libreBaskerville(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      '"$currentShloka"',
                      style: GoogleFonts.poppins(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.0,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    NeoPopButton(
                      color: Colors.black,
                      bottomShadowColor: accentColor,
                      depth: 5,
                      onTapUp: () {
                        _getRandomShloka();
                        HapticFeedback.vibrate();
                      },
                      onTapDown: () => HapticFeedback.vibrate(),
                      parentColor: accentColor,
                      buttonPosition: Position.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Change Shloka",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 12,
                                )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Lottie.network(
                        'https://lottie.host/29c39914-44d2-42be-860d-8db2b692c716/g8vFEyMsPW.json',
                        width: 350,
                        height: 350,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
