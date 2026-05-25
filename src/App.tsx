import { useState } from 'react';

const screens = [
  {
    id: 'splash',
    name: 'Splash Screen',
    description: 'Animated logo with system session check',
    content: (
      <div className="flex flex-col items-center justify-center h-full bg-gradient-to-br from-[#0F0F1A] via-[#1A1A35] to-[#0F1A35] relative overflow-hidden">
        {/* Glow blobs */}
        <div className="absolute top-16 -left-16 w-48 h-48 rounded-full bg-[#6C63FF]/15 blur-2xl" />
        <div className="absolute bottom-32 -right-10 w-36 h-36 rounded-full bg-[#FF6584]/12 blur-2xl" />
        <div className="absolute top-1/2 left-8 w-24 h-24 rounded-full bg-[#43C6AC]/10 blur-xl" />
        {/* Logo */}
        <div className="w-28 h-28 rounded-full bg-gradient-to-br from-[#6C63FF] to-[#FF6584] flex items-center justify-center shadow-[0_0_60px_rgba(108,99,255,0.5)] animate-pulse">
          <span className="text-5xl">⚡</span>
        </div>
        <h1 className="text-white font-black text-4xl mt-8 tracking-tight">ResolveX</h1>
        <p className="text-white/50 text-sm mt-2 tracking-widest uppercase">Smart Daily Problem Solving</p>
        <div className="flex gap-2 mt-16">
          {[0,1,2].map(i => (
            <div key={i} className="h-2 rounded-full animate-pulse" style={{width: i===0?'20px':'8px', backgroundColor: i===0?'#6C63FF':i===1?'#FF6584':'#43C6AC', animationDelay:`${i*150}ms`}} />
          ))}
        </div>
      </div>
    )
  },
  {
    id: 'onboarding',
    name: 'Onboarding',
    description: '4-slide beautiful intro with smooth transitions',
    content: (
      <div className="flex flex-col h-full bg-[#1A1535] relative overflow-hidden">
        <div className="absolute -top-16 -right-16 w-56 h-56 rounded-full bg-[#6C63FF]/15" />
        <div className="absolute bottom-24 -left-20 w-48 h-48 rounded-full bg-[#6C63FF]/10" />
        <div className="absolute top-4 right-5 px-4 py-1.5 rounded-full border border-white/20 bg-white/10">
          <span className="text-white/60 text-xs font-medium">Skip</span>
        </div>
        <div className="flex-1 flex flex-col items-start px-7 pt-20 pb-6">
          <div className="w-36 h-36 rounded-full border-2 border-[#6C63FF]/40 bg-[#6C63FF]/20 flex items-center justify-center self-center mb-8">
            <span className="text-7xl">🧠</span>
          </div>
          <div className="flex flex-wrap gap-2 self-center mb-10">
            {['😰','😴','💸','📱','😤'].map(e => (
              <div key={e} className="px-3 py-1.5 rounded-full bg-white/8 border border-white/12">
                <span className="text-xl">{e}</span>
              </div>
            ))}
          </div>
          <h1 className="text-white font-black text-3xl leading-none mb-4">Solve Real Life<br/>Problems Daily</h1>
          <div className="w-14 h-1 rounded-full bg-gradient-to-r from-[#6C63FF] to-[#8E54E9] mb-4" />
          <p className="text-white/60 text-sm leading-relaxed">Access science-backed solutions for the 10 most common daily life challenges — from stress to financial struggles.</p>
        </div>
        <div className="px-7 pb-8 flex items-center justify-between">
          <div className="flex gap-2">
            {[0,1,2,3].map(i => (
              <div key={i} className="h-2 rounded-full" style={{width: i===0?'28px':'8px', backgroundColor: i===0?'#6C63FF':'rgba(255,255,255,0.2)'}} />
            ))}
          </div>
          <div className="w-14 h-14 rounded-full bg-gradient-to-r from-[#6C63FF] to-[#8E54E9] flex items-center justify-center shadow-[0_8px_20px_rgba(108,99,255,0.4)]">
            <span className="text-white text-xl">→</span>
          </div>
        </div>
      </div>
    )
  },
  {
    id: 'login',
    name: 'Login Screen',
    description: 'Email/password auth with form validation',
    content: (
      <div className="flex flex-col h-full bg-gradient-to-br from-[#EEE CFF] to-[#F5F3FF] relative overflow-hidden">
        <div className="absolute -top-20 -left-20 w-72 h-72 rounded-full bg-[#6C63FF]/12" />
        <div className="absolute top-1/4 -right-16 w-44 h-44 rounded-full bg-[#FF6584]/8" />
        <div className="flex-1 px-7 flex flex-col justify-center gap-6">
          <div className="flex flex-col items-center gap-3">
            <div className="w-20 h-20 rounded-full bg-gradient-to-br from-[#6C63FF] to-[#FF6584] flex items-center justify-center shadow-[0_8px_24px_rgba(108,99,255,0.4)]">
              <span className="text-4xl">⚡</span>
            </div>
            <h1 className="text-[#1A1A2E] font-black text-3xl">Welcome Back</h1>
            <p className="text-[#888] text-sm">Sign in to continue your journey</p>
          </div>
          <div className="bg-white rounded-3xl p-6 shadow-[0_10px_30px_rgba(0,0,0,0.08)] flex flex-col gap-4">
            <div className="bg-[#F0F2F5] rounded-2xl px-5 py-4 flex items-center gap-3">
              <span className="text-[#AAAAAA]">✉️</span>
              <span className="text-[#AAAAAA] text-sm">Email address</span>
            </div>
            <div className="bg-[#F0F2F5] rounded-2xl px-5 py-4 flex items-center gap-3">
              <span className="text-[#AAAAAA]">🔒</span>
              <span className="text-[#AAAAAA] text-sm">Password</span>
              <span className="ml-auto text-[#AAAAAA] text-xs">👁</span>
            </div>
            <div className="self-end">
              <span className="text-[#6C63FF] text-sm font-semibold">Forgot password?</span>
            </div>
            <div className="w-full h-14 rounded-2xl bg-gradient-to-r from-[#6C63FF] to-[#8E54E9] flex items-center justify-center shadow-[0_8px_20px_rgba(108,99,255,0.4)]">
              <span className="text-white font-semibold text-base">🔑 Sign In</span>
            </div>
          </div>
          <div className="w-full h-14 rounded-2xl border border-[#6C63FF]/30 bg-[#6C63FF]/07 flex items-center justify-center">
            <span className="text-[#6C63FF] font-semibold text-sm">⚡ Continue as Demo User</span>
          </div>
          <div className="text-center text-sm text-[#888]">
            Don't have an account? <span className="text-[#6C63FF] font-bold">Sign Up</span>
          </div>
        </div>
      </div>
    )
  },
  {
    id: 'home',
    name: 'Home Screen',
    description: 'Search bar + GridView of 10 categories',
    content: (
      <div className="flex flex-col h-full bg-[#F0F2F5]">
        {/* Header */}
        <div className="bg-gradient-to-br from-[#F0F2F5] to-[#EAE8FF] px-5 pt-10 pb-3">
          <div className="flex items-center justify-between mb-3">
            <div>
              <p className="text-[#888] text-xs">Good morning,</p>
              <h2 className="text-[#1A1A2E] font-black text-xl">DemoUser 👋</h2>
            </div>
            <div className="w-11 h-11 rounded-full bg-gradient-to-br from-[#6C63FF] to-[#FF6584] flex items-center justify-center shadow-[0_4px_12px_rgba(108,99,255,0.35)]">
              <span className="text-white font-bold text-lg">D</span>
            </div>
          </div>
          {/* Stats banner */}
          <div className="w-full rounded-2xl bg-gradient-to-r from-[#6C63FF] to-[#8E54E9] p-4 flex items-center justify-between shadow-[0_8px_20px_rgba(108,99,255,0.35)] mb-3">
            <div>
              <p className="text-white font-bold text-sm">🎯 20 Solutions Ready</p>
              <p className="text-white/75 text-xs mt-0.5">Viewed: 3 · Saved: 2</p>
            </div>
            <div className="px-3 py-1.5 rounded-xl bg-white/15">
              <span className="text-white text-xs font-semibold">10 Topics</span>
            </div>
          </div>
          {/* Search bar */}
          <div className="bg-white rounded-2xl px-4 py-3.5 flex items-center gap-3 shadow-sm">
            <span className="text-[#AAAAAA]">🔍</span>
            <span className="text-[#AAAAAA] text-sm">Search problems, solutions...</span>
          </div>
        </div>
        {/* Categories grid */}
        <div className="flex-1 overflow-y-auto px-4 pt-3 pb-20">
          <p className="text-[#1A1A2E] font-bold text-base mb-3">10 Problem Categories</p>
          <div className="grid grid-cols-2 gap-3">
            {[
              {emoji:'🧘',name:'Stress Management',color:'from-[#FF6B9D] to-[#FF8E53]'},
              {emoji:'⏰',name:'Time Management',color:'from-[#4776E6] to-[#8E54E9]'},
              {emoji:'😴',name:'Sleep Issues',color:'from-[#1A1A2E] to-[#16213E]'},
              {emoji:'💰',name:'Financial Problems',color:'from-[#11998E] to-[#38EF7D]'},
              {emoji:'🎯',name:'Focus Problems',color:'from-[#FC466B] to-[#3F5EFB]'},
              {emoji:'📱',name:'Mobile Addiction',color:'from-[#F7971E] to-[#FFD200]'},
              {emoji:'🌊',name:'Anxiety',color:'from-[#667EEA] to-[#764BA2]'},
              {emoji:'🚀',name:'Productivity',color:'from-[#00B4DB] to-[#0083B0]'},
              {emoji:'🔥',name:'Motivation',color:'from-[#F83600] to-[#F9D423]'},
              {emoji:'💪',name:'Health Habits',color:'from-[#56AB2F] to-[#A8E063]'},
            ].map((cat, i) => (
              <div key={i} className={`rounded-3xl bg-gradient-to-br ${cat.color} p-4 aspect-square flex flex-col justify-between relative overflow-hidden shadow-lg`}>
                <div className="absolute -top-4 -right-4 w-20 h-20 rounded-full bg-white/10" />
                <div className="absolute bottom-2 right-4 w-14 h-14 rounded-full bg-white/8" />
                <div className="w-12 h-12 rounded-2xl bg-white/20 flex items-center justify-center">
                  <span className="text-2xl">{cat.emoji}</span>
                </div>
                <div>
                  <p className="text-white font-bold text-sm leading-tight">{cat.name}</p>
                  <div className="mt-1.5 px-2 py-0.5 rounded-full bg-white/20 inline-block">
                    <span className="text-white/90 text-xs">2 solutions</span>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>
    )
  },
  {
    id: 'detail',
    name: 'Detail Screen',
    description: 'Step-by-step solutions with progress tracking',
    content: (
      <div className="flex flex-col h-full bg-[#F0F2F5]">
        {/* Hero */}
        <div className="bg-gradient-to-br from-[#FF6B9D] to-[#FF8E53] px-5 pt-10 pb-6 relative overflow-hidden">
          <div className="absolute -top-8 -right-8 w-44 h-44 rounded-full bg-white/8" />
          <div className="flex items-center justify-between mb-4">
            <div className="w-10 h-10 rounded-xl bg-black/25 flex items-center justify-center">
              <span className="text-white text-sm">←</span>
            </div>
            <div className="w-10 h-10 rounded-xl bg-black/25 flex items-center justify-center">
              <span className="text-xl">🔖</span>
            </div>
          </div>
          <div className="inline-flex items-center gap-2 px-3 py-1.5 rounded-full bg-white/20 border border-white/30 mb-3">
            <span className="text-sm">🧘</span>
            <span className="text-white text-xs font-semibold">Stress Management</span>
          </div>
          <h2 className="text-white font-black text-xl leading-tight mb-3">Overwhelmed by Daily Tasks</h2>
          <div className="flex items-center justify-between mb-1.5">
            <span className="text-white/75 text-xs">Progress</span>
            <span className="text-white text-xs font-semibold">3/7 steps</span>
          </div>
          <div className="h-1.5 rounded-full bg-white/20 overflow-hidden">
            <div className="h-full w-2/5 rounded-full bg-white" />
          </div>
        </div>
        {/* Steps */}
        <div className="flex-1 overflow-y-auto px-4 pt-4 pb-20 flex flex-col gap-2">
          <p className="text-[#1A1A2E] font-bold text-base mb-1">📋 Step-by-Step Action Plan</p>
          {[
            {n:1, text:'Start a "brain dump" — write every task without filtering.', done:true},
            {n:2, text:'Categorize into 4 buckets: Urgent/Important matrix.', done:true},
            {n:3, text:'Schedule only 3 "Most Important Tasks" for today.', done:true},
            {n:4, text:'Use Pomodoro: 25 min work, 5 min rest. Repeat 4x.', done:false},
            {n:5, text:'Practice box breathing when stress spikes.', done:false},
          ].map(step => (
            <div key={step.n} className={`rounded-2xl p-4 flex items-start gap-3 ${step.done?'bg-[#FF6B9D]/8 border border-[#FF6B9D]/40':'bg-white'} shadow-sm`}>
              <div className={`w-8 h-8 rounded-xl flex items-center justify-center shrink-0 ${step.done?'bg-gradient-to-br from-[#FF6B9D] to-[#FF8E53]':'bg-[#F0F2F5]'}`}>
                {step.done ? <span className="text-white text-sm">✓</span> : <span className="text-[#FF6B9D] text-xs font-bold">{step.n}</span>}
              </div>
              <p className={`text-sm leading-relaxed ${step.done?'text-[#AAAAAA] line-through':'text-[#333]'}`}>{step.text}</p>
            </div>
          ))}
          <div className="mt-2 rounded-2xl bg-white p-4 shadow-sm border border-[#FF6B9D]/20">
            <div className="flex items-center gap-2 mb-3">
              <span className="text-xl">✨</span>
              <span className="text-[#FF6B9D] font-bold text-sm">Expert Tips</span>
            </div>
            <div className="flex gap-3">
              <div className="w-1 rounded-full bg-gradient-to-b from-[#FF6B9D] to-[#FF8E53]" />
              <p className="text-xs text-[#555] leading-relaxed">💡 Writing stress down reduces amygdala activation by up to 30%.</p>
            </div>
          </div>
        </div>
      </div>
    )
  },
  {
    id: 'saved',
    name: 'Saved Screen',
    description: 'Bookmarked solutions with swipe-to-delete',
    content: (
      <div className="flex flex-col h-full bg-[#F0F2F5]">
        <div className="bg-[#F0F2F5] px-5 pt-12 pb-3 flex items-center justify-between">
          <div>
            <h2 className="text-[#1A1A2E] font-black text-xl">Saved Solutions</h2>
            <p className="text-[#888] text-xs">2 solutions bookmarked</p>
          </div>
          <span className="text-[#FF6584]/80 text-2xl">🗑️</span>
        </div>
        <div className="px-5 pt-1 pb-2 flex gap-2">
          {[{icon:'🔖',label:'2 Saved',color:'#6C63FF'},{icon:'📂',label:'2 Categories',color:'#FF6584'}].map((chip,i) => (
            <div key={i} className="px-3 py-1.5 rounded-full border flex items-center gap-1.5" style={{borderColor:chip.color+'50',backgroundColor:chip.color+'15'}}>
              <span className="text-xs">{chip.icon}</span>
              <span className="text-xs font-semibold" style={{color:chip.color}}>{chip.label}</span>
            </div>
          ))}
        </div>
        <p className="px-5 text-[#1A1A2E] font-bold text-base mb-2 mt-2">Your Bookmarks</p>
        <div className="flex-1 overflow-y-auto px-4 pb-20 flex flex-col gap-3">
          {[
            {emoji:'🧘',title:'Overwhelmed by Daily Tasks',cat:'Stress Management',steps:7,color:'from-[#FF6B9D] to-[#FF8E53]'},
            {emoji:'💰',title:'Living Paycheck to Paycheck',cat:'Financial Problems',steps:7,color:'from-[#11998E] to-[#38EF7D]'},
          ].map((item,i) => (
            <div key={i} className="bg-white rounded-2xl p-4 flex items-center gap-3 shadow-sm relative overflow-hidden">
              <div className={`w-14 h-14 rounded-2xl bg-gradient-to-br ${item.color} flex items-center justify-center shrink-0`}>
                <span className="text-3xl">{item.emoji}</span>
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-[#1A1A2E] font-bold text-sm leading-tight mb-1.5">{item.title}</p>
                <div className="flex items-center gap-2">
                  <div className="px-2 py-0.5 rounded-lg bg-[#FF6B9D]/12">
                    <span className="text-[#FF6B9D] text-xs font-semibold">{item.cat}</span>
                  </div>
                  <span className="text-[#888] text-xs">{item.steps} steps</span>
                </div>
              </div>
              <div className="flex flex-col items-center gap-1.5">
                <div className="w-9 h-9 rounded-xl bg-[#FF6584]/10 flex items-center justify-center">
                  <span className="text-[#FF6584] text-base">🗑</span>
                </div>
                <span className="text-[#CCC] text-xs">›</span>
              </div>
            </div>
          ))}
          <div className="rounded-2xl border border-dashed border-[#CCCCCC] p-5 flex flex-col items-center gap-2 mt-2">
            <span className="text-3xl">🔖</span>
            <p className="text-[#888] text-xs text-center">Swipe left on any card to delete,<br/>or tap 🗑️ for options</p>
          </div>
        </div>
      </div>
    )
  },
  {
    id: 'profile',
    name: 'Profile Screen',
    description: 'Stats, theme toggle, and logout',
    content: (
      <div className="flex flex-col h-full bg-[#F0F2F5]">
        {/* Profile card */}
        <div className="mx-4 mt-10 rounded-3xl bg-gradient-to-br from-[#6C63FF] to-[#8E54E9] p-6 flex flex-col items-center gap-3 shadow-[0_10px_24px_rgba(108,99,255,0.4)]">
          <div className="w-20 h-20 rounded-full bg-white/20 border-2 border-white/40 flex items-center justify-center">
            <span className="text-white font-black text-3xl">D</span>
          </div>
          <div className="text-center">
            <h2 className="text-white font-black text-xl">DemoUser</h2>
            <p className="text-white/70 text-sm">demo@resolvex.app</p>
          </div>
          <div className="px-4 py-2 rounded-full bg-white/15 border border-white/25 flex items-center gap-2">
            <span className="text-white text-sm">✅</span>
            <span className="text-white text-xs font-semibold">Premium Problem Solver</span>
          </div>
        </div>
        {/* Stats */}
        <div className="px-4 mt-5">
          <p className="text-[#1A1A2E] font-bold text-base mb-3">📊 Your Stats</p>
          <div className="flex gap-3">
            {[
              {v:'5',l:'Solutions\nViewed',c:'from-[#6C63FF] to-[#8E54E9]',icon:'👁'},
              {v:'2',l:'Solutions\nSaved',c:'from-[#FF6B9D] to-[#FF8E53]',icon:'🔖'},
              {v:'10',l:'Categories\nAvailable',c:'from-[#11998E] to-[#38EF7D]',icon:'📂'},
            ].map((s,i) => (
              <div key={i} className={`flex-1 rounded-2xl bg-gradient-to-br ${s.c} p-4 flex flex-col items-center gap-1.5 shadow-lg`}>
                <span className="text-xl">{s.icon}</span>
                <span className="text-white font-black text-2xl">{s.v}</span>
                <span className="text-white/80 text-xs text-center leading-tight whitespace-pre-line">{s.l}</span>
              </div>
            ))}
          </div>
        </div>
        {/* Settings */}
        <div className="px-4 mt-5 flex flex-col gap-3">
          <p className="text-[#1A1A2E] font-bold text-base">⚙️ Preferences</p>
          <div className="bg-white rounded-2xl p-4 flex items-center gap-3 shadow-sm">
            <div className="w-10 h-10 rounded-xl bg-[#F9D423]/15 flex items-center justify-center">
              <span className="text-xl">☀️</span>
            </div>
            <div className="flex-1">
              <p className="text-[#1A1A2E] font-semibold text-sm">Light Mode</p>
              <p className="text-[#888] text-xs">Switch to dark for night use</p>
            </div>
            <div className="w-11 h-6 rounded-full bg-[#6C63FF] relative">
              <div className="absolute right-0.5 top-0.5 w-5 h-5 rounded-full bg-white shadow-sm" />
            </div>
          </div>
          <div className="bg-white rounded-2xl p-4 flex items-center gap-3 shadow-sm">
            <div className="w-10 h-10 rounded-xl bg-[#FF6584]/12 flex items-center justify-center">
              <span className="text-xl">🔔</span>
            </div>
            <div className="flex-1">
              <p className="text-[#1A1A2E] font-semibold text-sm">Daily Reminders</p>
              <p className="text-[#888] text-xs">Get nudged to solve one problem daily</p>
            </div>
            <div className="w-11 h-6 rounded-full bg-[#FF6584] relative">
              <div className="absolute right-0.5 top-0.5 w-5 h-5 rounded-full bg-white shadow-sm" />
            </div>
          </div>
          <button className="w-full h-14 rounded-2xl border border-[#FF6584]/30 bg-[#FF6584]/8 flex items-center justify-center gap-2">
            <span className="text-xl">🚪</span>
            <span className="text-[#FF6584] font-semibold text-sm">Sign Out</span>
          </button>
        </div>
      </div>
    )
  }
];

export default function App() {
  const [activeScreen, setActiveScreen] = useState('home');
  const [activeTab, setActiveTab] = useState(0);
  const current = screens.find(s => s.id === activeScreen) || screens[3];

  const tabs = [
    {id:'home',label:'Home',icon:'🏠',screenId:'home'},
    {id:'saved',label:'Saved',icon:'🔖',screenId:'saved'},
    {id:'profile',label:'Profile',icon:'👤',screenId:'profile'},
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-[#0F0F1A] via-[#1A1535] to-[#0A0A18] flex flex-col items-center justify-start p-4 md:p-8">
      {/* Header */}
      <div className="w-full max-w-6xl mb-8 text-center">
        <div className="flex items-center justify-center gap-3 mb-3">
          <div className="w-10 h-10 rounded-full bg-gradient-to-br from-[#6C63FF] to-[#FF6584] flex items-center justify-center shadow-[0_0_20px_rgba(108,99,255,0.5)]">
            <span className="text-xl">⚡</span>
          </div>
          <h1 className="text-white font-black text-3xl md:text-4xl tracking-tight">ResolveX</h1>
        </div>
        <p className="text-white/50 text-sm tracking-wider uppercase">Smart Daily Problem Solving System</p>
        <div className="flex flex-wrap gap-2 justify-center mt-4">
          {['Flutter 3.x', 'Dart', 'Provider', 'SharedPreferences', 'Google Fonts', 'Hive', 'Dark/Light Mode'].map(tag => (
            <span key={tag} className="px-3 py-1 rounded-full bg-white/8 border border-white/15 text-white/60 text-xs font-medium">{tag}</span>
          ))}
        </div>
      </div>

      <div className="w-full max-w-6xl grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Phone Preview */}
        <div className="lg:col-span-1 flex flex-col items-center">
          <div className="relative" style={{width:'320px'}}>
            {/* Phone frame */}
            <div className="relative bg-[#0A0A0A] rounded-[48px] p-2 shadow-2xl shadow-black/60 border border-white/10">
              <div className="absolute top-5 left-1/2 -translate-x-1/2 w-24 h-5 bg-[#0A0A0A] rounded-full z-10 border border-white/10" />
              <div className="rounded-[40px] overflow-hidden bg-white" style={{height:'640px'}}>
                {current.content}
              </div>
            </div>
            {/* Bottom nav overlay for main screens */}
            {['home','saved','profile'].includes(activeScreen) && (
              <div className="absolute bottom-2 left-2 right-2 bg-white/95 backdrop-blur rounded-b-[38px] shadow-lg px-4 py-2 flex items-center justify-around z-20">
                {tabs.map((tab, i) => (
                  <button
                    key={tab.id}
                    onClick={() => { setActiveTab(i); setActiveScreen(tab.screenId); }}
                    className={`flex items-center gap-1.5 px-3 py-2 rounded-2xl transition-all ${activeTab===i?'bg-[#6C63FF]/12':'bg-transparent'}`}
                  >
                    <span className="text-lg">{tab.icon}</span>
                    {activeTab === i && <span className="text-[#6C63FF] font-semibold text-xs">{tab.label}</span>}
                  </button>
                ))}
              </div>
            )}
          </div>
          <p className="text-white/40 text-xs mt-4 text-center">Interactive screen preview</p>
        </div>

        {/* Screen Selector + Info Panel */}
        <div className="lg:col-span-2 flex flex-col gap-5">
          {/* Screen nav */}
          <div>
            <h2 className="text-white/60 text-xs uppercase tracking-widest mb-3 font-semibold">📱 App Screens</h2>
            <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-2">
              {screens.map(screen => (
                <button
                  key={screen.id}
                  onClick={() => {
                    setActiveScreen(screen.id);
                    if(screen.id==='home') setActiveTab(0);
                    if(screen.id==='saved') setActiveTab(1);
                    if(screen.id==='profile') setActiveTab(2);
                  }}
                  className={`p-3 rounded-2xl text-left transition-all border ${activeScreen===screen.id?'bg-[#6C63FF]/20 border-[#6C63FF]/50 shadow-[0_0_12px_rgba(108,99,255,0.2)]':'bg-white/5 border-white/10 hover:bg-white/8'}`}
                >
                  <p className={`text-xs font-semibold ${activeScreen===screen.id?'text-[#8E54E9]':'text-white/70'}`}>{screen.name}</p>
                </button>
              ))}
            </div>
          </div>

          {/* Current screen info */}
          <div className="bg-white/5 rounded-3xl border border-white/10 p-5">
            <div className="flex items-center gap-3 mb-4">
              <div className="w-8 h-8 rounded-xl bg-gradient-to-br from-[#6C63FF] to-[#8E54E9] flex items-center justify-center">
                <span className="text-white text-sm">📱</span>
              </div>
              <div>
                <h3 className="text-white font-bold text-base">{current.name}</h3>
                <p className="text-white/50 text-xs">{current.description}</p>
              </div>
            </div>
          </div>

          {/* Architecture overview */}
          <div className="bg-white/5 rounded-3xl border border-white/10 p-5">
            <h3 className="text-white font-bold text-sm mb-4">🏗️ Flutter Project Architecture</h3>
            <div className="grid grid-cols-1 sm:grid-cols-2 gap-2">
              {[
                {file:'lib/main.dart', desc:'Entry point with MultiProvider setup'},
                {file:'lib/models/problem_model.dart', desc:'Data models + 20 pre-loaded solutions'},
                {file:'lib/providers/app_provider.dart', desc:'State, search, favorites, sessions'},
                {file:'lib/providers/theme_provider.dart', desc:'Dark/Light mode with SharedPreferences'},
                {file:'lib/screens/splash_screen.dart', desc:'Animated logo + session check'},
                {file:'lib/screens/onboarding_screen.dart', desc:'4-slide smooth intro slider'},
                {file:'lib/screens/login_screen.dart', desc:'Form validation + demo auth'},
                {file:'lib/screens/signup_screen.dart', desc:'Account registration + terms'},
                {file:'lib/screens/main_layout.dart', desc:'Animated BottomNavigationBar'},
                {file:'lib/screens/home_screen.dart', desc:'Search + category grid + featured'},
                {file:'lib/screens/detail_screen.dart', desc:'Steps, tips, progress tracking'},
                {file:'lib/screens/saved_screen.dart', desc:'Bookmarks with dismissible delete'},
                {file:'lib/screens/profile_screen.dart', desc:'Stats, theme toggle, logout'},
                {file:'lib/widgets/custom_widgets.dart', desc:'15+ reusable UI components'},
                {file:'pubspec.yaml', desc:'All dependencies configured'},
              ].map(item => (
                <div key={item.file} className="flex items-start gap-2 py-1.5">
                  <span className="text-[#6C63FF] text-xs mt-0.5 shrink-0">▸</span>
                  <div>
                    <p className="text-[#8E54E9] text-xs font-mono font-medium">{item.file}</p>
                    <p className="text-white/40 text-xs">{item.desc}</p>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* 10 Categories */}
          <div className="bg-white/5 rounded-3xl border border-white/10 p-5">
            <h3 className="text-white font-bold text-sm mb-4">🎯 10 Mandatory Categories (20 Solutions)</h3>
            <div className="grid grid-cols-2 gap-2">
              {[
                {e:'🧘',n:'Stress Management',c:2},
                {e:'⏰',n:'Time Management',c:2},
                {e:'😴',n:'Sleep Issues',c:2},
                {e:'💰',n:'Financial Problems',c:2},
                {e:'🎯',n:'Focus Problems',c:2},
                {e:'📱',n:'Mobile Addiction',c:2},
                {e:'🌊',n:'Anxiety',c:2},
                {e:'🚀',n:'Productivity',c:2},
                {e:'🔥',n:'Motivation',c:2},
                {e:'💪',n:'Health Habits',c:2},
              ].map((cat,i) => (
                <div key={i} className="flex items-center gap-2 py-1.5 px-3 rounded-xl bg-white/4 border border-white/8">
                  <span className="text-lg">{cat.e}</span>
                  <div className="flex-1 min-w-0">
                    <p className="text-white/80 text-xs font-medium truncate">{cat.n}</p>
                    <p className="text-white/30 text-xs">{cat.c} solutions</p>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* Run Instructions */}
          <div className="bg-gradient-to-br from-[#6C63FF]/15 to-[#8E54E9]/10 rounded-3xl border border-[#6C63FF]/30 p-5">
            <h3 className="text-white font-bold text-sm mb-3">🚀 How to Run on Device</h3>
            <div className="flex flex-col gap-2">
              {[
                'flutter pub get',
                'flutter run',
                '# Or for specific platform:',
                'flutter run -d android',
                'flutter run -d ios',
                'flutter build apk --release',
              ].map((cmd, i) => (
                <div key={i} className={`px-3 py-2 rounded-xl font-mono text-xs ${cmd.startsWith('#')?'text-white/35':'bg-black/30 text-[#A8FFE0] border border-white/10'}`}>
                  {cmd}
                </div>
              ))}
            </div>
          </div>
        </div>
      </div>

      <div className="w-full max-w-6xl mt-6 text-center">
        <p className="text-white/25 text-xs">ResolveX — Complete Flutter & Dart native mobile application • 14 files • Production-ready</p>
      </div>
    </div>
  );
}
