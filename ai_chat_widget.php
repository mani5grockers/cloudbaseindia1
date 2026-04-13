<?php
// includes/hooks/ai_chat_widget.php

add_hook('ClientAreaPage', 1, function ($vars) {

    if (!in_array($vars['templatefile'], [
        'clientareahome',
        'supportticketsubmit-stepone',
        'homepage'
    ])) {
        return;
    }

    $clientName = 'Guest';
    if (!empty($vars['clientsdetails']['firstname'])) {
        $clientName = $vars['clientsdetails']['firstname'];
    }

    return [
        'showAIChat'   => true,
        'aiClientName' => $clientName,
    ];
});

add_hook('ClientAreaFooterOutput', 1, function ($vars) {

    if (empty($vars['showAIChat'])) {
        return '';
    }

    $clientName = htmlspecialchars($vars['aiClientName'], ENT_QUOTES);

return '
<style>
:root {
  --ai-primary: linear-gradient(135deg,#6366f1,#8b5cf6,#22d3ee);
  --ai-bg: rgba(15,23,42,0.75);
  --ai-border: rgba(255,255,255,0.15);
}

#ai-chat-widget {
  position:fixed;
  bottom:69px;
  right:54px;
  width:370px;
  height:536px;
  backdrop-filter: blur(20px);
  background: var(--ai-bg);
  border:1px solid var(--ai-border);
  border-radius:20px;
  box-shadow:0 25px 80px rgba(0,0,0,0.45);
  z-index:9999;
  overflow:hidden;
  font-family: Inter,system-ui,Arial;
  transform-origin: bottom right;
  transition: transform .35s ease, opacity .35s ease;
}

#ai-chat-widget.minimized {
  opacity:0;
  transform: scale(.85) translateY(30px);
  pointer-events:none;
}

#ai-chat-widget.closed {
  display:none;
}

.ai-header {
  background: var(--ai-primary);
  padding:14px 16px;
  color:#fff;
  display:flex;
  align-items:center;
  justify-content:space-between;
}

.ai-header-left {
  display:flex;
  align-items:center;
  gap:10px;
}

.ai-avatar {
  width:38px;
  height:38px;
  border-radius:12px;
  background:rgba(255,255,255,.25);
  display:flex;
  align-items:center;
  justify-content:center;
  font-size:18px;
}

.ai-header-buttons {
  display:flex;
  gap:10px;
}

.ai-minimize,
.ai-close {
  cursor:pointer;
  font-size:20px;
  line-height:1;
  opacity:.9;
}

#chat-messages {
  height:360px;
  overflow-y:auto;
  padding:16px;
  display:flex;
  flex-direction:column;
  gap:12px;
}

.ai-msg, .user-msg {
  max-width:80%;
  padding:12px 14px;
  border-radius:14px;
  font-size:14px;
  line-height:1.5;
}

.user-msg {
  align-self:flex-end;
  background:#22c55e;
  color:#03210f;
}

.ai-msg {
  align-self:flex-start;
  background:rgba(255,255,255,.12);
  color:#e5e7eb;
}

.ai-input {
  display:flex;
  gap:8px;
  padding:14px;
  border-top:1px solid var(--ai-border);
}

.ai-input input {
  flex:1;
  background:rgba(255,255,255,.1);
  border:1px solid var(--ai-border);
  color:#fff;
  padding:12px 14px;
  border-radius:14px;
}

.ai-input button {
  background: var(--ai-primary);
  border:none;
  padding:0 18px;
  color:#fff;
  border-radius:14px;
  cursor:pointer;
  font-weight:700;
}

/* Auto-hide toggle when chat is open */
#ai-chat-widget:not(.minimized):not(.closed) ~ #ai-chat-toggle {
  opacity: 0;
  pointer-events: none;
  transform: scale(0.8);
}

/* ✨ Pulse only when .pulse class exists */
#ai-chat-toggle.pulse {
  animation: aiPulse 3.2s ease-in-out infinite;
}

#ai-chat-toggle:hover {
  box-shadow:
    0 0 0 10px rgba(99,102,241,0.15),
    0 18px 45px rgba(99,102,241,0.75);
  transform: scale(1.06);
}

@keyframes aiPulse {
  0% {
    box-shadow:0 0 0 0 rgba(99,102,241,.55);
  }
  50% {
    box-shadow:0 0 0 18px rgba(99,102,241,0);
  }
  100% {
    box-shadow:0 0 0 0 rgba(99,102,241,0);
  }
}

#ai-chat-toggle {
  position:fixed;
  bottom:60px;
  right:10px;
  width:64px;
  height:64px;
  border-radius:50%;
  background: var(--ai-primary);
  border:none;
  color:#fff;
  font-size:39px;
  cursor:pointer;
  box-shadow:0 20px 50px rgba(99,102,241,.6);
  z-index:9998;
  display:flex;
  align-items:center;
  justify-content:center;
  line-height:1;
  padding:0;
}
</style>


<style>
.ai-bg-left,
.ai-bg-right {
  position: fixed;
  width: 200px;
  height: 200px;
  opacity: .15;
  pointer-events: none;
  z-index: 9000;
}
</style>

<div id="ai-chat-widget" class="minimized">
  <div class="ai-header">
    <div class="ai-header-left">
      <div class="ai-avatar">֎</div>
      <div>
        <strong>AI Assistant</strong><br>
        <span style="font-size:11px;opacity:.85">Instant help • 24/7</span>
      </div>
    </div>

    <div class="ai-header-buttons">
      <div class="ai-minimize" id="ai-minimize">—</div>
      <div class="ai-close" id="ai-close">×</div>
    </div>
  </div>

  <div id="chat-messages">
    <div class="ai-msg">
      👋 Hi <strong>'.$clientName.'</strong>!<br>
      I’m your CloudBaseIndia AI assistant.
    </div>
  </div>

  <div class="ai-input">
    <input id="chat-input" placeholder="Type your question…" />
    <button id="chat-send">➤</button>
  </div>
</div>

<button id="ai-chat-toggle">💬</button>

<script>
const widget = document.getElementById("ai-chat-widget");
const toggleBtn = document.getElementById("ai-chat-toggle");
const minimizeBtn = document.getElementById("ai-minimize");
const closeBtn = document.getElementById("ai-close");

// 💤 Pulse only before first open
if (!localStorage.getItem("aiChatOpened")) {
  toggleBtn.classList.add("pulse");
}

function markOpenedOnce() {
  if (!localStorage.getItem("aiChatOpened")) {
    localStorage.setItem("aiChatOpened", "1");
    toggleBtn.classList.remove("pulse");
  }
}

function openChat() {
  widget.classList.remove("minimized","closed");
  markOpenedOnce();

  // auto-hide toggle
  toggleBtn.style.opacity = "0";
  toggleBtn.style.pointerEvents = "none";
}


function minimizeChat() {
  widget.classList.add("minimized");

  toggleBtn.style.opacity = "1";
  toggleBtn.style.pointerEvents = "auto";
}

function closeChat() {
  widget.classList.add("closed");

  toggleBtn.style.opacity = "1";
  toggleBtn.style.pointerEvents = "auto";
}


toggleBtn.onclick = function(e){
  e.stopPropagation();
  openChat();
};

minimizeBtn.onclick = function(e){
  e.stopPropagation();
  minimizeChat();
};

closeBtn.onclick = function(e){
  e.stopPropagation();
  closeChat();
};

// 🖱 Auto-close when clicking outside the chat widget
document.addEventListener("click", function (e) {

  // Ignore if widget is closed or minimized
  if (
    widget.classList.contains("closed") ||
    widget.classList.contains("minimized")
  ) {
    return;
  }

  // Click inside widget → ignore
  if (widget.contains(e.target)) {
    return;
  }

  // Click on chat toggle button → ignore
  if (toggleBtn.contains(e.target)) {
    return;
  }

  // Otherwise → close chat
minimizeChat();
});


document.getElementById("chat-send").onclick = sendMessage;
document.getElementById("chat-input").addEventListener("keydown", e => {
  if (e.key === "Enter") sendMessage();
});

async function sendMessage() {
  const input = document.getElementById("chat-input");
  const msg = input.value.trim();
  if (!msg) return;

  const box = document.getElementById("chat-messages");
  box.innerHTML += "<div class=\"user-msg\">" + msg + "</div>";
  input.value = "";
  box.scrollTop = box.scrollHeight;

  const typing = document.createElement("div");
  typing.className = "ai-msg";
  typing.innerText = "Typing...";
  box.appendChild(typing);

  try {
    const res = await fetch("/ai_chat_proxy.php", {
      method:"POST",
      headers:{"Content-Type":"application/json"},
      body:JSON.stringify({message:msg})
    });
    const data = await res.json();
    typing.remove();

    box.innerHTML += "<div class=\"ai-msg\">" +
      (data.reply || "Sorry, I couldn’t reply.").replace(/\\n/g,"<br>") +
      "</div>";
  } catch {
    typing.innerText = "⚠️ Network error";
  }

  box.scrollTop = box.scrollHeight;
}
</script>
';
});
