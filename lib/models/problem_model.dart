// lib/models/problem_model.dart

class ProblemCategory {
  final String id;
  final String title;
  final String description;
  final String emoji;
  final List<String> gradientColors;
  final List<Problem> problems;

  const ProblemCategory({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.gradientColors,
    required this.problems,
  });
}

class Problem {
  final String id;
  final String categoryId;
  final String categoryTitle;
  final String categoryEmoji;
  final String title;
  final String shortDescription;
  final String fullDescription;
  final List<String> steps;
  final List<String> tips;
  final List<String> gradientColors;
  bool isFavorite;

  Problem({
    required this.id,
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryEmoji,
    required this.title,
    required this.shortDescription,
    required this.fullDescription,
    required this.steps,
    required this.tips,
    required this.gradientColors,
    this.isFavorite = false,
  });

  Problem copyWith({
    String? id,
    String? categoryId,
    String? categoryTitle,
    String? categoryEmoji,
    String? title,
    String? shortDescription,
    String? fullDescription,
    List<String>? steps,
    List<String>? tips,
    List<String>? gradientColors,
    bool? isFavorite,
  }) {
    return Problem(
      id: id ?? this.id,
      categoryId: categoryId ?? this.categoryId,
      categoryTitle: categoryTitle ?? this.categoryTitle,
      categoryEmoji: categoryEmoji ?? this.categoryEmoji,
      title: title ?? this.title,
      shortDescription: shortDescription ?? this.shortDescription,
      fullDescription: fullDescription ?? this.fullDescription,
      steps: steps ?? this.steps,
      tips: tips ?? this.tips,
      gradientColors: gradientColors ?? this.gradientColors,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryId': categoryId,
      'categoryTitle': categoryTitle,
      'categoryEmoji': categoryEmoji,
      'title': title,
      'shortDescription': shortDescription,
      'fullDescription': fullDescription,
      'steps': steps,
      'tips': tips,
      'gradientColors': gradientColors,
      'isFavorite': isFavorite,
    };
  }

  factory Problem.fromMap(Map<String, dynamic> map) {
    return Problem(
      id: map['id'] ?? '',
      categoryId: map['categoryId'] ?? '',
      categoryTitle: map['categoryTitle'] ?? '',
      categoryEmoji: map['categoryEmoji'] ?? '',
      title: map['title'] ?? '',
      shortDescription: map['shortDescription'] ?? '',
      fullDescription: map['fullDescription'] ?? '',
      steps: List<String>.from(map['steps'] ?? []),
      tips: List<String>.from(map['tips'] ?? []),
      gradientColors: List<String>.from(map['gradientColors'] ?? []),
      isFavorite: map['isFavorite'] ?? false,
    );
  }
}

// ─── MOCK DATA ───────────────────────────────────────────────────────────────

final List<ProblemCategory> mockCategories = [
  // 1. Stress Management
  ProblemCategory(
    id: 'stress',
    title: 'Stress Management',
    description: 'Techniques to reduce and manage daily stress',
    emoji: '🧘',
    gradientColors: ['FF6B9D', 'FF8E53'],
    problems: [
      Problem(
        id: 'stress_001',
        categoryId: 'stress',
        categoryTitle: 'Stress Management',
        categoryEmoji: '🧘',
        title: 'Overwhelmed by Daily Tasks',
        shortDescription: 'Feel crushed under a mountain of responsibilities? Regain control today.',
        fullDescription:
            'Feeling overwhelmed is one of the most common stress triggers in modern life. When your to-do list feels endless and your energy is depleted, your body enters a fight-or-flight response that impairs decision-making and creativity. This guide provides a proven, structured approach to reclaim your mental bandwidth and face each day with confidence and clarity.',
        steps: [
          'Start a "brain dump" — write every task, worry, and thought on paper for 10 minutes without filtering.',
          'Categorize tasks into 4 buckets: Urgent & Important, Important but Not Urgent, Urgent but Not Important, and Neither.',
          'Schedule only 3 "Most Important Tasks" (MITs) for today. Everything else is secondary.',
          'Use the Pomodoro Technique: work 25 minutes, rest 5 minutes. Repeat 4 cycles, then take a 30-minute break.',
          'Practice box breathing: inhale 4 counts, hold 4, exhale 4, hold 4. Repeat 5 times when stress spikes.',
          'At day\'s end, review what you accomplished — not what you didn\'t — and celebrate small wins.',
          'Prepare tomorrow\'s top 3 tasks the night before to reduce morning decision fatigue.',
        ],
        tips: [
          '💡 Research shows that writing stress down reduces amygdala activation by up to 30%.',
          '🌿 A 10-minute walk in nature lowers cortisol levels more than any screen-based relaxation.',
          '🎵 Listening to 60 BPM music (like classical or lo-fi) synchronizes brainwaves to a calm state.',
          '⏰ The "2-minute rule": if a task takes less than 2 minutes, do it immediately — it clears mental clutter.',
        ],
        gradientColors: ['FF6B9D', 'FF8E53'],
      ),
      Problem(
        id: 'stress_002',
        categoryId: 'stress',
        categoryTitle: 'Stress Management',
        categoryEmoji: '🧘',
        title: 'Work-Life Balance Crisis',
        shortDescription: 'Reclaim your personal time and set healthy professional boundaries.',
        fullDescription:
            'When work bleeds into every aspect of your personal life, chronic stress and burnout follow. Many professionals struggle to define where work ends and life begins, especially in the age of remote work and constant connectivity. This plan will help you create firm, healthy boundaries that protect your wellbeing without harming your career.',
        steps: [
          'Define your "shutdown ritual" — a specific action (e.g., closing laptop, saying "shutdown complete") that signals the end of the workday.',
          'Turn off all work notifications on your phone after 7 PM using your phone\'s Do Not Disturb settings.',
          'Block personal time in your calendar the same way you block meetings — treat it as non-negotiable.',
          'Communicate boundaries clearly to colleagues: "I\'m available Monday–Friday, 9 AM–6 PM."',
          'Create a dedicated workspace at home. When you leave it, you\'ve "left work."',
          'Schedule at least one full off-grid hour per day with no screens, phones, or digital input.',
          'Weekly: review if work invaded personal time and adjust one boundary accordingly.',
        ],
        tips: [
          '🔕 "Always on" culture is a myth — studies show workers are most productive with clear off-hours.',
          '🏠 Physical separation (even a dedicated chair) trains your brain to switch modes more effectively.',
          '📅 Saying "no" to one non-essential meeting per day reclaims over 4 hours per week.',
          '🧠 Recovery time is not wasted time — it\'s when the brain consolidates learning and refuels creativity.',
        ],
        gradientColors: ['FF6B9D', 'C850C0'],
      ),
      Problem(
        id: 'stress_003',
        categoryId: 'stress',
        categoryTitle: 'Stress Management',
        categoryEmoji: '🧘',
        title: 'Emotional Burnout',
        shortDescription: 'Identify burnout early and rebuild your energy reserves systematically.',
        fullDescription:
            'Burnout is not simply being tired — it\'s a state of chronic depletion across emotional, physical, and mental dimensions. Recognized by the WHO as an occupational phenomenon, burnout can take months to fully recover from if left unaddressed. This guide helps you identify your burnout stage and take targeted recovery actions starting today.',
        steps: [
          'Take the Maslach Burnout Inventory self-assessment (available free online) to identify your burnout stage.',
          'For one week, track your energy levels hourly (1-10 scale) to identify your peak and trough periods.',
          'Eliminate or delegate one significant energy drain from your week immediately.',
          'Add one "energy deposit" activity daily — something you genuinely enjoy with zero productivity pressure.',
          'Sleep is non-negotiable: commit to 7–9 hours for the next 30 days as a recovery protocol.',
          'Speak to one trusted person about how you\'re feeling — social connection is a proven burnout remedy.',
          'Consider a professional counselor or therapist if burnout has lasted more than 2 weeks.',
        ],
        tips: [
          '🔥 Burnout can masquerade as laziness or apathy — don\'t moralize it, treat it medically.',
          '💤 Sleep deprivation amplifies negative emotions by 60% (UC Berkeley study).',
          '🤝 Vulnerability and asking for help accelerates recovery far faster than soldiering through.',
          '🌱 Micro-recoveries (5–10 minute breaks) throughout the day prevent burnout accumulation.',
        ],
        gradientColors: ['FF8E53', 'FFC837'],
      ),
    ],
  ),

  // 2. Time Management
  ProblemCategory(
    id: 'time',
    title: 'Time Management',
    description: 'Master your schedule and achieve more in less time',
    emoji: '⏰',
    gradientColors: ['4776E6', '8E54E9'],
    problems: [
      Problem(
        id: 'time_001',
        categoryId: 'time',
        categoryTitle: 'Time Management',
        categoryEmoji: '⏰',
        title: 'Chronic Procrastination',
        shortDescription: 'Break the procrastination cycle with behavioral psychology techniques.',
        fullDescription:
            'Procrastination is not a time management problem — it\'s an emotion management problem. We delay tasks because they trigger feelings of anxiety, boredom, self-doubt, or resentment. Understanding this root cause is the first step to permanent change. This guide applies evidence-based behavioral science to dismantle procrastination at its source.',
        steps: [
          'Identify your procrastination trigger: Is it anxiety? Boredom? Perfectionism? Write it down for each avoided task.',
          'Apply the "10-minute rule": commit to working on the task for just 10 minutes. Most people continue naturally.',
          'Break the feared task into its absolute smallest first step (not "write report" but "open the document").',
          'Use implementation intentions: "I will [task] at [time] in [location]." Specificity triples follow-through.',
          'Remove friction: prepare everything you need the night before so starting requires zero decisions.',
          'Create accountability: tell someone your specific task and deadline for today.',
          'Reward yourself immediately after completing the task — your brain learns to associate it with pleasure.',
        ],
        tips: [
          '🧪 Procrastination activates the same brain region as physical pain — it genuinely hurts to start.',
          '🎯 "Done is better than perfect" — perfectionism is procrastination wearing a productive disguise.',
          '📱 Put your phone in another room while working. Visual presence alone reduces cognitive capacity by 10%.',
          '⚡ Your future self will thank you — visualizing your future self builds motivation more than willpower.',
        ],
        gradientColors: ['4776E6', '8E54E9'],
      ),
      Problem(
        id: 'time_002',
        categoryId: 'time',
        categoryTitle: 'Time Management',
        categoryEmoji: '⏰',
        title: 'Poor Schedule Planning',
        shortDescription: 'Build a realistic, sustainable daily schedule that actually works.',
        fullDescription:
            'Most people fail at scheduling because they plan for an ideal day, not a real one. They underestimate task duration (planning fallacy), forget buffer time, and don\'t account for energy fluctuations. This system teaches you to build schedules that survive contact with reality, using time-blocking and energy management together.',
        steps: [
          'Time audit: for 3 days, track every activity in 30-minute blocks. Discover where your time actually goes.',
          'Identify your chronotype: are you a morning person (lion), intermediate (bear), evening (wolf), or cautious (dolphin)?',
          'Block your peak energy hours (usually 2–4 hours) exclusively for your most demanding, high-value work.',
          'Batch similar tasks together (all emails, all calls, all admin) to reduce context-switching costs.',
          'Add 20% buffer time to every estimated task duration — tasks always take longer than expected.',
          'Use the "MIT Method": identify 1–3 Most Important Tasks each morning and complete them before anything else.',
          'Do a weekly review every Sunday: what worked, what didn\'t, what to adjust next week.',
        ],
        tips: [
          '📊 Context switching costs 23 minutes of recovery time per interruption — protect your deep work blocks.',
          '🌙 Schedule creative work when you\'re naturally alert, not when you force yourself to be.',
          '📱 Email and messages should be checked at scheduled times, not continuously throughout the day.',
          '✅ Planning your week on Sunday increases productivity by up to 40% (Harvard Business Review).',
        ],
        gradientColors: ['4776E6', '00C9FF'],
      ),
    ],
  ),

  // 3. Sleep Issues
  ProblemCategory(
    id: 'sleep',
    title: 'Sleep Issues',
    description: 'Fix your sleep patterns and wake up refreshed every day',
    emoji: '😴',
    gradientColors: ['1A1A2E', '16213E'],
    problems: [
      Problem(
        id: 'sleep_001',
        categoryId: 'sleep',
        categoryTitle: 'Sleep Issues',
        categoryEmoji: '😴',
        title: 'Insomnia & Racing Mind',
        shortDescription: 'Quiet the mental noise and fall asleep faster using science-backed methods.',
        fullDescription:
            'Insomnia affects 1 in 3 adults and is often perpetuated by the anxiety of not sleeping — you can\'t sleep, so you worry about not sleeping, which makes sleep even harder. This creates a vicious cycle. Cognitive Behavioral Therapy for Insomnia (CBT-I) is the most effective long-term treatment, outperforming sleeping pills without side effects. This guide walks you through its core principles.',
        steps: [
          'Establish a consistent sleep-wake time — even on weekends — within ±30 minutes. This anchors your circadian rhythm.',
          'Create a 30-minute "wind-down" routine before bed: dim lights, no screens, gentle reading or stretching.',
          'If you can\'t sleep within 20 minutes, get up and do something calm in dim light until you feel sleepy. Don\'t lie awake in bed.',
          'Use your bed only for sleep and intimacy — not work, TV, or scrolling. This rebuilds the bed-sleep mental association.',
          'Try Progressive Muscle Relaxation: tense then release each muscle group from toes to head.',
          'Write down tomorrow\'s concerns in a "worry journal" 2 hours before bed — offloads mental processing.',
          'Keep your bedroom cool (65–68°F / 18–20°C), dark, and quiet. Consider white noise or blackout curtains.',
        ],
        tips: [
          '📱 Blue light from screens suppresses melatonin by up to 50% — stop screens 1 hour before bed.',
          '☕ Caffeine has a 5-hour half-life — a 4 PM coffee still affects you at 9 PM.',
          '🌡️ A slightly cooler body temperature signals sleep onset — a warm bath 1–2 hours before bed paradoxically helps.',
          '🧠 "Sleep effort" (trying too hard to sleep) is itself a cause of insomnia — relaxation, not effort, is the goal.',
        ],
        gradientColors: ['1A1A2E', '16213E'],
      ),
      Problem(
        id: 'sleep_002',
        categoryId: 'sleep',
        categoryTitle: 'Sleep Issues',
        categoryEmoji: '😴',
        title: 'Irregular Sleep Schedule',
        shortDescription: 'Reset your body clock and build consistent, restorative sleep patterns.',
        fullDescription:
            'An irregular sleep schedule is one of the most damaging things you can do to your health, impairing everything from hormone regulation to immune function to cognitive performance. Social jetlag (a mismatch between your internal clock and social schedule) affects over 40% of the population. This protocol will systematically reset your circadian rhythm within 2 weeks.',
        steps: [
          'Choose a target wake time and stick to it for 14 consecutive days — this is your circadian anchor.',
          'On the first day, delay your bedtime by 15 minutes each day until it aligns with your target.',
          'Get bright light exposure (sunlight or 10,000 lux lamp) within 30 minutes of your target wake time.',
          'Avoid naps longer than 20 minutes, and never nap after 3 PM.',
          'Eat meals at consistent times — meal timing is a secondary circadian cue (zeitgeber).',
          'Exercise regularly, but finish vigorous exercise at least 3 hours before bedtime.',
          'Track your sleep for 2 weeks using a free app (Sleep Cycle, etc.) to identify patterns.',
        ],
        tips: [
          '☀️ Morning light exposure is the single most powerful tool to reset your circadian clock.',
          '🍺 Alcohol destroys sleep quality even if it helps you fall asleep — it suppresses REM sleep.',
          '⏰ Sleeping in on weekends more than 1 hour causes "social jetlag" — maintain consistency.',
          '📉 Just one night of 6-hour sleep impairs performance equal to 24 hours without sleep.',
        ],
        gradientColors: ['667EEA', '764BA2'],
      ),
    ],
  ),

  // 4. Financial Problems
  ProblemCategory(
    id: 'finance',
    title: 'Financial Problems',
    description: 'Take control of your money and build lasting financial health',
    emoji: '💰',
    gradientColors: ['11998E', '38EF7D'],
    problems: [
      Problem(
        id: 'finance_001',
        categoryId: 'finance',
        categoryTitle: 'Financial Problems',
        categoryEmoji: '💰',
        title: 'Living Paycheck to Paycheck',
        shortDescription: 'Break the cycle with practical budgeting and an emergency fund plan.',
        fullDescription:
            'Over 60% of Americans live paycheck to paycheck regardless of income — this is a behavior pattern, not purely an income problem. The paycheck-to-paycheck cycle is driven by lifestyle inflation, lack of automated saving, and an absent emergency fund. This step-by-step plan will break you out of the cycle within 90 days using proven financial behavior techniques.',
        steps: [
          'Track every expense for 30 days using a free app (Mint, YNAB, or even a spreadsheet). Awareness is the foundation.',
          'Calculate your net income. Apply the 50/30/20 rule: 50% needs, 30% wants, 20% savings/debt.',
          'Open a separate high-yield savings account labeled "Emergency Fund" and automate a transfer on payday.',
          'Your initial emergency fund goal: \$1,000. This prevents 90% of financial crises from becoming catastrophic.',
          'List all subscriptions and cancel any not used in the last 30 days — average person wastes \$237/month on unused subscriptions.',
          'Negotiate at least one bill this month (insurance, phone, internet) — providers expect this.',
          'Find one "expense leak" per week: coffee runs, food delivery fees, impulse purchases under \$20.',
        ],
        tips: [
          '💡 Automate savings on payday — if it never hits your checking account, you won\'t miss it.',
          '🎯 The psychological power of a named savings account ("Emergency Fund") increases contribution rates.',
          '📊 Budgeting apps reduce overspending by 15–20% simply through awareness, with no willpower required.',
          '💳 Paying with cash (or a cash-equivalent mental accounting system) reduces spending by 12–18% vs. cards.',
        ],
        gradientColors: ['11998E', '38EF7D'],
      ),
      Problem(
        id: 'finance_002',
        categoryId: 'finance',
        categoryTitle: 'Financial Problems',
        categoryEmoji: '💰',
        title: 'Debt Spiral',
        shortDescription: 'Choose the right debt elimination strategy and execute it systematically.',
        fullDescription:
            'Debt feels overwhelming because it is a systemic problem — interest compounds against you every day. But with the right strategy, even significant debt can be eliminated systematically. The two most proven methods are the Debt Snowball (psychological wins) and Debt Avalanche (mathematically optimal). This guide helps you choose and execute the right one for your psychology.',
        steps: [
          'List all debts: creditor, balance, minimum payment, and interest rate. This is your debt inventory.',
          'Choose your strategy: Snowball (smallest balance first) for motivation, or Avalanche (highest rate first) to save the most money.',
          'Pay every minimum payment on all debts to protect your credit score. Then put ALL extra money to your target debt.',
          'Find \$100–\$200 extra per month through expense cuts, side income, or selling unused items.',
          'Call each creditor and ask for an interest rate reduction — success rates are 50–70% for good customers.',
          'Consider balance transfer to a 0% APR card for high-interest credit card debt (watch transfer fees).',
          'Celebrate each debt paid off — the dopamine from wins fuels the motivation to continue.',
        ],
        tips: [
          '📈 The Snowball method is psychologically superior for 70% of people — small wins build momentum.',
          '📞 Simply calling to negotiate your rate can save hundreds of dollars with a single 10-minute call.',
          '🏦 NEVER close paid-off credit cards — this hurts your credit utilization ratio and credit score.',
          '💪 Every dollar applied to debt earns a guaranteed return equal to the interest rate — better than most investments.',
        ],
        gradientColors: ['F7971E', 'FFD200'],
      ),
    ],
  ),

  // 5. Focus Problems
  ProblemCategory(
    id: 'focus',
    title: 'Focus Problems',
    description: 'Sharpen your concentration and enter deep work states',
    emoji: '🎯',
    gradientColors: ['FC466B', '3F5EFB'],
    problems: [
      Problem(
        id: 'focus_001',
        categoryId: 'focus',
        categoryTitle: 'Focus Problems',
        categoryEmoji: '🎯',
        title: 'Constant Distraction & Loss of Focus',
        shortDescription: 'Engineer your environment for deep work and eliminate distraction by design.',
        fullDescription:
            'Deep focus is not a personality trait — it is a skill that can be trained, and an environment that can be engineered. In an age of constant notifications, open-plan offices, and infinite scrolling feeds, distraction is the default state. Protecting your focus requires both environmental design and neurological training. This guide gives you both.',
        steps: [
          'Digital detox prep: use your phone\'s Screen Time (iOS) or Digital Wellbeing (Android) to see your actual daily usage.',
          'Enable "Focus Mode" or "Do Not Disturb" on all devices during deep work blocks — no exceptions.',
          'Use website blockers (Freedom, Cold Turkey) to block distracting sites for scheduled deep work periods.',
          'Design your physical workspace: clear desk, only current task materials visible, headphones as a "focus signal."',
          'Start each deep work session with a 2-minute "focus ritual": write the single deliverable for this session.',
          'Train your focus like a muscle: start with 25 minutes of uninterrupted focus, increase by 5 minutes weekly.',
          'After each session, log what distracted you — patterns will emerge, which you can then specifically address.',
        ],
        tips: [
          '🧠 It takes an average of 23 minutes to regain deep focus after an interruption (Gloria Mark, UCI).',
          '🎧 Binaural beats at 40 Hz (gamma) have shown measurable improvements in concentration in studies.',
          '🌱 A cluttered desk is linked to higher cortisol and poorer executive function — clean your space first.',
          '⚡ Your brain has a finite "focus budget" per day — use it on high-value work, not email.',
        ],
        gradientColors: ['FC466B', '3F5EFB'],
      ),
      Problem(
        id: 'focus_002',
        categoryId: 'focus',
        categoryTitle: 'Focus Problems',
        categoryEmoji: '🎯',
        title: 'Multi-tasking Trap',
        shortDescription: 'Stop multi-tasking and start achieving more through single-task focus.',
        fullDescription:
            'Multi-tasking is a myth — the brain cannot actually process two cognitive tasks simultaneously. What you experience as multi-tasking is rapid task-switching, which carries a significant cognitive cost. Research by Stanford and MIT shows multi-taskers perform worse on virtually every metric: memory, focus, attention, creativity, and task completion speed. This guide teaches you to achieve more by doing less at once.',
        steps: [
          'Single-task commitment: choose ONE task per work block. Write it on a sticky note in front of you.',
          'Close every browser tab, app, and document not related to your current task.',
          'Use a physical notepad to capture "thought interruptions" (other tasks that pop into mind) without switching tasks.',
          'Schedule communication blocks: reply to all messages at 10 AM, 1 PM, and 5 PM only.',
          'Use the "Parking Lot" technique: write non-urgent ideas and tasks in a list for later — your brain can then let go.',
          'Review your calendar for any meeting that could be an email. Protect your single-tasking time blocks.',
          'Practice mindful transitions: completely finish and close one task before starting the next, even if it takes 2 extra minutes.',
        ],
        tips: [
          '📉 Multi-tasking reduces productivity by up to 40% and IQ by up to 10 points (University of London).',
          '📝 The "Parking Lot" technique reduces "intrusive thoughts" about other tasks by 37% (Zeigarnik effect research).',
          '📧 Email is the #1 destroyer of focus — batch it, don\'t stream it.',
          '🏆 The top 1% of performers in any field share one trait: they single-task ruthlessly and protect their time.',
        ],
        gradientColors: ['F953C6', 'B91D73'],
      ),
    ],
  ),

  // 6. Mobile Addiction
  ProblemCategory(
    id: 'mobile',
    title: 'Mobile Addiction',
    description: 'Reclaim your life from smartphone overuse and digital dependency',
    emoji: '📱',
    gradientColors: ['F7971E', 'FFD200'],
    problems: [
      Problem(
        id: 'mobile_001',
        categoryId: 'mobile',
        categoryTitle: 'Mobile Addiction',
        categoryEmoji: '📱',
        title: 'Compulsive Phone Checking',
        shortDescription: 'Break the dopamine loop of compulsive phone checking with proven behavioral strategies.',
        fullDescription:
            'The average person checks their phone 96 times per day — once every 10 minutes. Social media apps are engineered by teams of psychologists and engineers to maximize compulsive usage through variable reward schedules (the same mechanism as slot machines). This guide uses behavioral science to systematically dismantle the habit loop and rebuild a healthy relationship with technology.',
        steps: [
          'Download your screen time report. Face the truth — most people underestimate usage by 50%.',
          'Turn off ALL non-essential push notifications. Keep only calls and critical app alerts.',
          'Move social media apps off your home screen into a folder three swipes away — friction is powerful.',
          'Designate "phone-free zones": bedroom, dining table, first 30 minutes and last 30 minutes of the day.',
          'Replace the first morning phone check with a 5-minute intentional activity: stretch, breathe, or journal.',
          'Set app time limits on social media (15–30 minutes per day) using native Screen Time/Digital Wellbeing settings.',
          'Create a "phone charging station" outside your bedroom — never sleep with your phone within arm\'s reach.',
        ],
        tips: [
          '🎰 Variable reward schedules (like social media feeds) are the most addictive behavioral pattern known.',
          '🌅 The first 30 minutes of your day set your neurological tone — protect them from external input.',
          '🔴 Red dot notification badges create urgency anxiety — turn off all badge notifications.',
          '📖 Every hour of phone time replaced with reading, exercise, or in-person connection dramatically boosts wellbeing.',
        ],
        gradientColors: ['F7971E', 'FFD200'],
      ),
      Problem(
        id: 'mobile_002',
        categoryId: 'mobile',
        categoryTitle: 'Mobile Addiction',
        categoryEmoji: '📱',
        title: 'Doom Scrolling Habit',
        shortDescription: 'Stop the endless news scroll and take back your mental health.',
        fullDescription:
            'Doom scrolling — consuming endless streams of negative news and social content — triggers a fear response in the amygdala, flooding the body with cortisol and adrenaline. This keeps you "watching" for threats (more bad news) in an evolutionary response that was designed for physical dangers, not digital ones. The result: anxiety, depression, sleep disruption, and a distorted worldview. This guide breaks the cycle.',
        steps: [
          'Schedule ONE 15-minute "news window" per day — consume deliberately, then stop. Most news can wait.',
          'Unfollow or mute any account that consistently makes you feel anxious, angry, or inadequate.',
          'Replace doom scrolling triggers (boredom, waiting time) with a specific alternative: a podcast, book, or breathing exercise.',
          'Install a news aggregator that shows you exactly what you\'ve read — making consumption visible reduces it.',
          'When you feel the urge to scroll, ask: "What am I feeling that I\'m trying to avoid?" Address the feeling directly.',
          'Create a "joyful content list": accounts, books, or podcasts that consistently make you feel good. Return to these.',
          'Social media sabbath: one 24-hour period per week with zero social media. Notice how you feel afterward.',
        ],
        tips: [
          '📰 News organizations are incentivized to maximize anxiety — negativity gets 3x more engagement than good news.',
          '🧠 30 days of reduced news consumption measurably reduces anxiety and depression scores.',
          '🌍 You can stay informed without being consumed — quality over quantity, scheduled over reactive.',
          '✂️ Unfollowing is not anti-social — it\'s mental health protection. You curate what enters your mind.',
        ],
        gradientColors: ['FDC830', 'F37335'],
      ),
    ],
  ),

  // 7. Anxiety
  ProblemCategory(
    id: 'anxiety',
    title: 'Anxiety',
    description: 'Practical tools to manage anxiety and restore inner calm',
    emoji: '🌊',
    gradientColors: ['667EEA', '764BA2'],
    problems: [
      Problem(
        id: 'anxiety_001',
        categoryId: 'anxiety',
        categoryTitle: 'Anxiety',
        categoryEmoji: '🌊',
        title: 'Generalized Daily Anxiety',
        shortDescription: 'Interrupt anxiety patterns with grounding techniques and cognitive restructuring.',
        fullDescription:
            'Generalized anxiety is characterized by persistent, excessive worry that is difficult to control and affects daily functioning. Unlike situational anxiety (which is normal and useful), generalized anxiety creates a baseline of worry that erodes quality of life over time. This guide combines evidence-based techniques from CBT, mindfulness, and somatic therapy to provide immediate relief and long-term resilience.',
        steps: [
          'Use the 5-4-3-2-1 grounding technique when anxiety spikes: name 5 things you see, 4 you can touch, 3 you hear, 2 you smell, 1 you taste.',
          'Practice diaphragmatic breathing: breathe into your belly (not chest) for 4 counts, hold 1, exhale 6 counts. The long exhale activates the parasympathetic system.',
          'Schedule a daily "worry window": 20 minutes where you actively worry about everything. Outside this window, postpone worries to the next session.',
          'Challenge anxious thoughts with the ABCDE model: Adversity, Belief, Consequence, Dispute, Effect.',
          'Physical movement is powerful: even a 20-minute walk reduces anxiety for up to 4 hours afterward.',
          'Limit alcohol and caffeine — both chemically exacerbate anxiety symptoms even in moderate amounts.',
          'Consider journaling as a "cognitive offload" — writing worries down reduces their perceived intensity.',
        ],
        tips: [
          '🧘 Mindfulness meditation for 8 weeks produces measurable changes in amygdala (fear center) size.',
          '💪 Regular aerobic exercise is as effective as medication for mild-to-moderate anxiety (multiple meta-analyses).',
          '🫁 The breath is the only automatic body function you can manually control — use it as your anxiety remote control.',
          '📞 If anxiety is severe, constant, or significantly impairing daily life, please consult a mental health professional.',
        ],
        gradientColors: ['667EEA', '764BA2'],
      ),
      Problem(
        id: 'anxiety_002',
        categoryId: 'anxiety',
        categoryTitle: 'Anxiety',
        categoryEmoji: '🌊',
        title: 'Social Anxiety',
        shortDescription: 'Build social confidence gradually through exposure and cognitive techniques.',
        fullDescription:
            'Social anxiety is the fear of negative evaluation by others — the terror of being judged, embarrassed, or rejected in social situations. It is the third most common mental health condition globally, affecting 12.1% of people at some point in their lives. The gold standard treatment is Cognitive Behavioral Therapy with graduated exposure. This guide provides a self-directed version of that approach.',
        steps: [
          'Build an "anxiety hierarchy": list social situations from least scary (talking to a cashier) to most scary (giving a presentation). Rate each 0–100.',
          'Start with the lowest-ranked situation and deliberately expose yourself to it once daily for one week.',
          'While in the situation, resist "safety behaviors" (looking at your phone, avoiding eye contact) — they maintain anxiety.',
          'Practice cognitive defusion: notice the thought "They\'ll think I\'m stupid" as just a thought, not a fact.',
          'After social events, resist post-event processing (replaying what went wrong) — it reinforces anxiety.',
          'Practice "opposite action": when you want to flee or avoid, deliberately stay 5 more minutes.',
          'Celebrate exposure attempts, not outcomes — courage is the victory, not perfection.',
        ],
        tips: [
          '🔬 People are far less focused on your flaws than you believe — this is called the Spotlight Effect.',
          '💬 Most people are thinking about themselves, not judging you — we overestimate others\' scrutiny by 400%.',
          '📈 Avoidance maintains and strengthens anxiety — only gradual, repeated exposure permanently reduces it.',
          '🌟 Every social anxiety success story began with one small, terrifying step — yours does too.',
        ],
        gradientColors: ['A18CD1', 'FBC2EB'],
      ),
    ],
  ),

  // 8. Productivity
  ProblemCategory(
    id: 'productivity',
    title: 'Productivity',
    description: 'Systems and habits to multiply your output and impact',
    emoji: '🚀',
    gradientColors: ['00B4DB', '0083B0'],
    problems: [
      Problem(
        id: 'prod_001',
        categoryId: 'productivity',
        categoryTitle: 'Productivity',
        categoryEmoji: '🚀',
        title: 'Low Output Despite High Effort',
        shortDescription: 'Shift from being busy to being productive with strategic prioritization.',
        fullDescription:
            'Being busy and being productive are opposites. Busyness is reactive — responding to emails, attending meetings, and handling others\' priorities. Productivity is proactive — creating, deciding, and building toward your goals. Most people spend 80% of their time on low-value activities that generate 20% of their results (Pareto Principle). This guide teaches you to invert that ratio.',
        steps: [
          'Conduct a "task audit": list every regular task and rate it 1–10 on its actual impact on your core goals.',
          'Identify your "80/20": which 20% of your activities produce 80% of your meaningful results? Do more of those.',
          'Ruthlessly eliminate, automate, or delegate tasks below a 5/10 impact rating.',
          'Design a "Ideal Week" template in your calendar showing where deep work, admin, and creative tasks belong.',
          'Apply "strategic laziness": solve every recurring problem once by creating a system, not by handling it repeatedly.',
          'Measure outputs, not hours — track deliverables, decisions made, and goals advanced, not time at desk.',
          'Weekly review: did this week move your most important projects forward? Adjust next week accordingly.',
        ],
        tips: [
          '⚡ 20% of your tasks generate 80% of your results — identify and protect that 20% ruthlessly.',
          '🤖 Every task you automate or systemize frees future time permanently — invest time now to save time forever.',
          '📧 Email is rarely in your top 20% of value-creating activities — treat it accordingly.',
          '🏆 True productivity is about life advancement, not task completion. Are you moving toward your goals?',
        ],
        gradientColors: ['00B4DB', '0083B0'],
      ),
      Problem(
        id: 'prod_002',
        categoryId: 'productivity',
        categoryTitle: 'Productivity',
        categoryEmoji: '🚀',
        title: 'Decision Fatigue',
        shortDescription: 'Reduce daily decisions to preserve mental energy for what matters most.',
        fullDescription:
            'Decision fatigue is real and scientifically documented — the quality of your decisions degrades with each decision you make throughout the day. This is why judges give harsher sentences after lunch, and why Steve Jobs wore the same outfit every day. By reducing the number of trivial decisions you make, you preserve cognitive resources for the decisions that actually matter.',
        steps: [
          'Identify your top 5 recurring trivial decisions: what to eat, what to wear, when to exercise, what to watch, etc.',
          'Create "decision rules" or defaults for each: e.g., "Mondays: eggs for breakfast" or "workout at 7 AM always."',
          'Plan your meals for the week on Sundays — this eliminates 21+ daily food decisions.',
          'Create a "capsule wardrobe" with versatile pieces that all coordinate — eliminates morning outfit decisions.',
          'Use templates for recurring emails, documents, and reports — decisions already made.',
          'Batch similar decisions together: review all investment decisions on one day, all vendor decisions on another.',
          'Make your most important decisions before 12 PM when your decision-making quality is highest.',
        ],
        tips: [
          '⚙️ Obama and Zuckerberg both eliminated wardrobe decisions to preserve mental energy — it\'s not eccentric, it\'s strategic.',
          '🍽️ Meal prepping eliminates 21 food decisions per week and typically saves \$100–\$200 in unnecessary purchases.',
          '📋 A checklist converts repeated complex decisions into a single "did I follow the checklist?" decision.',
          '🌅 Morning routines are powerful because they eliminate 20+ morning decisions through automation.',
        ],
        gradientColors: ['43C6AC', '191654'],
      ),
    ],
  ),

  // 9. Motivation
  ProblemCategory(
    id: 'motivation',
    title: 'Motivation',
    description: 'Reignite your drive and sustain it through systems, not willpower',
    emoji: '🔥',
    gradientColors: ['F83600', 'F9D423'],
    problems: [
      Problem(
        id: 'motiv_001',
        categoryId: 'motivation',
        categoryTitle: 'Motivation',
        categoryEmoji: '🔥',
        title: 'Loss of Drive & Purpose',
        shortDescription: 'Rediscover your "why" and build a life that pulls you forward every morning.',
        fullDescription:
            'A chronic lack of motivation is often a signal that you\'re pursuing the wrong goals, or pursuing the right goals for the wrong reasons. Motivation research distinguishes between intrinsic motivation (driven by genuine interest and meaning) and extrinsic motivation (driven by rewards and external validation). Intrinsic motivation is vastly more sustainable. This guide helps you reconnect with what genuinely matters to you.',
        steps: [
          'Complete the "5 Whys" exercise for your main goal: ask "why" 5 times to uncover your deepest motivator.',
          'Write your personal "purpose statement" in one sentence: "I am at my best when I am _____ and it matters because _____."',
          'Identify your "vision": write a vivid, detailed description of your ideal life 5 years from now (career, health, relationships, freedom).',
          'Break your vision into "milestone goals" (1-year targets) and "habit commitments" (daily actions that lead there).',
          'Find your identity-based motivation: "I don\'t just want to run a marathon — I am a runner." Identity drives behavior.',
          'Create an "inspiration ritual": daily 5 minutes reading about someone who achieved what you want to achieve.',
          'Track tiny daily progress — forward momentum, however small, is the most reliable motivator ever discovered.',
        ],
        tips: [
          '🎯 Motivation follows action, not the reverse — start the thing, even imperfectly, and motivation often appears.',
          '🔍 If you\'ve lost motivation, ask what you\'ve gained: comfort, safety, certainty. These are motivation killers.',
          '📖 Identity-based habits (James Clear, Atomic Habits) outperform goal-based habits 2:1 for long-term adherence.',
          '🌟 Your "why" should make you emotional — if it doesn\'t move you, it won\'t move you to action either.',
        ],
        gradientColors: ['F83600', 'F9D423'],
      ),
      Problem(
        id: 'motiv_002',
        categoryId: 'motivation',
        categoryTitle: 'Motivation',
        categoryEmoji: '🔥',
        title: 'Habit Formation Failure',
        shortDescription: 'Build unbreakable habits using the science of behavioral change.',
        fullDescription:
            'Most people try to build habits through willpower — a finite, depletable resource. Science-backed habit formation uses environmental design, identity shift, and reward systems instead, making habits automatic rather than effortful. This guide applies the "Habit Loop" framework (cue, routine, reward) with the latest behavioral science to help you build habits that actually stick.',
        steps: [
          'Choose ONE new habit to build at a time. Multi-habit attempts fail 95% of the time.',
          'Apply "habit stacking": attach the new habit to an existing anchor. "After I [current habit], I will [new habit]."',
          'Use the "2-minute rule": start with a version of the habit that takes only 2 minutes. Build from there.',
          'Design your environment: make the desired behavior the path of least resistance. Put the book on your pillow. Lay out workout clothes the night before.',
          'Track your habit on a paper calendar using an X for each successful day. "Don\'t break the chain" is a powerful motivator.',
          'Never miss twice — one missed day is an accident, two is the start of a new (bad) habit.',
          'At 30 days, slightly increase the difficulty or duration to keep growing without losing the habit.',
        ],
        tips: [
          '🔗 Habit stacking is the most reliable habit formation technique — it leverages existing neural pathways.',
          '🌱 Identity is the root of behavior: "I am someone who exercises" produces more consistent action than "I want to lose weight."',
          '⏱️ It takes an average of 66 days (not 21) to form a new habit — be patient and track progress.',
          '🎁 The reward must come immediately after the habit for it to wire effectively — delayed rewards don\'t work.',
        ],
        gradientColors: ['FDC830', 'F37335'],
      ),
    ],
  ),

  // 10. Health Habits
  ProblemCategory(
    id: 'health',
    title: 'Health Habits',
    description: 'Build daily health foundations that energize every aspect of life',
    emoji: '💪',
    gradientColors: ['56AB2F', 'A8E063'],
    problems: [
      Problem(
        id: 'health_001',
        categoryId: 'health',
        categoryTitle: 'Health Habits',
        categoryEmoji: '💪',
        title: 'Sedentary Lifestyle',
        shortDescription: 'Escape the sitting epidemic and build sustainable daily movement.',
        fullDescription:
            'Sitting is being called "the new smoking" — and the data backs it up. Prolonged sitting (more than 8 hours/day) is linked to a 147% increased risk of cardiovascular disease, independent of exercise. Even if you exercise for 1 hour, 8 hours of sitting still causes metabolic dysfunction. The solution is not just more exercise but breaking up sedentary time throughout the day.',
        steps: [
          'Set a "move alarm" every 45–60 minutes. When it rings, stand and move for 2–5 minutes — walk, stretch, or do 10 squats.',
          'Use a standing desk or improvised standing workstation for at least 2 hours of your workday.',
          'Walk or cycle for any errand under 1 mile instead of driving.',
          'Take all non-essential phone calls while walking — this alone can add 3,000–5,000 steps daily.',
          'Build "movement snacks": 10 push-ups when you wake up, 10 squats before lunch, a 10-minute walk after dinner.',
          'Find an enjoyable form of movement — sport, dance, swimming — that doesn\'t feel like exercise.',
          'Track daily steps as a baseline: aim for 7,500–10,000 steps minimum (current research suggests 7,000 is the sweet spot).',
        ],
        tips: [
          '🚶 7,500 daily steps reduces all-cause mortality by 58% compared to 2,000 steps (JAMA study, 2021).',
          '⏰ Standing breaks every hour are metabolically equivalent to 30 minutes of moderate exercise.',
          '💃 Any movement you enjoy is better than the "optimal" exercise you skip — consistency beats intensity.',
          '🏋️ Muscle mass after age 30 declines 3–5% per decade without resistance training — start now.',
        ],
        gradientColors: ['56AB2F', 'A8E063'],
      ),
      Problem(
        id: 'health_002',
        categoryId: 'health',
        categoryTitle: 'Health Habits',
        categoryEmoji: '💪',
        title: 'Poor Nutrition & Hydration',
        shortDescription: 'Simple, science-backed eating habits that fuel peak mental and physical performance.',
        fullDescription:
            'You don\'t need a perfect diet — you need a good-enough diet that you can sustain. Research consistently shows that the Mediterranean diet pattern (whole foods, healthy fats, minimal processing) is optimal for both brain and body health. More importantly, hydration is the most underestimated factor in cognitive performance: even mild dehydration (1–2%) causes measurable drops in focus, memory, and mood.',
        steps: [
          'Start every morning with 16 oz (500 ml) of water before anything else — your body is dehydrated after sleep.',
          'Carry a 1-liter water bottle and finish it twice by 5 PM — most people achieve this by habit alone.',
          'Apply the "half-plate rule": fill half your plate with vegetables or fruit at every meal, without counting calories.',
          'Eliminate "liquid calories" first: sodas, energy drinks, and alcohol carry enormous calories with minimal nutrition.',
          'Plan and prep vegetables in advance: washed, cut, and ready to eat in the fridge increases consumption by 200%.',
          'Read ingredient labels: if sugar is in the first 3 ingredients, it\'s dessert, not food.',
          'Practice mindful eating: eat at a table, without screens, chewing slowly — this alone reduces caloric intake by 20%.',
        ],
        tips: [
          '💧 The brain is 73% water — a 1-2% drop in hydration causes measurable cognitive impairment.',
          '🥦 Adding vegetables, not eliminating junk, is psychologically easier and nutritionally more impactful.',
          '🚫 Ultra-processed foods are designed to override your satiety signals — the "can\'t stop" feeling is engineered.',
          '⏳ Eating within an 8–10 hour window (time-restricted eating) improves metabolic health without calorie restriction.',
        ],
        gradientColors: ['11998E', '38EF7D'],
      ),
    ],
  ),
];

// Helper to get all problems flat
List<Problem> getAllProblems() {
  return mockCategories.expand((cat) => cat.problems).toList();
}
