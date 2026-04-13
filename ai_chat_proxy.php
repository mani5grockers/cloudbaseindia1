<?php
// ai_chat_proxy.php - OpenRouter Secure Proxy with Auto Model Failover

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *'); // tighten in production

$apiKey = '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'; // 🔐 keep secret

// 🔁 MODEL PRIORITY LIST (top → bottom)
$models = [
    'openai/gpt-oss-120b',
    'deepseek/deepseek-chat-v3.1',
    'x-ai/grok-4-fast',
    'openai/gpt-4o-mini',
    'x-ai/grok-3-mini',
    'llama3-70b-8192',
    'mistralai/mistral-7b-instruct',
    'openrouter/free'
    
];

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['error' => 'Method not allowed']);
    exit;
}

$input = json_decode(file_get_contents('php://input'), true);
if (empty($input['message'])) {
    http_response_code(400);
    echo json_encode(['error' => 'No message provided']);
    exit;
}

$userMessage = trim($input['message']);

$messages = [
    [
        'role' => 'system',
        'content' =>
            'You are a helpful, friendly AI assistant for CloudBaseIndia web hosting.
             Answer clearly and professionally. Focus on hosting, domains, billing,
             cPanel, email, VPS, and server support.'
    ],
    ['role' => 'user', 'content' => $userMessage]
];

function callOpenRouter($apiKey, $model, $messages)
{
    $payload = [
        'model' => $model,
        'messages' => $messages,
        'temperature' => 0.7,
        'max_tokens' => 300,
    ];

    $ch = curl_init('https://openrouter.ai/api/v1/chat/completions');
    curl_setopt_array($ch, [
        CURLOPT_RETURNTRANSFER => true,
        CURLOPT_POST => true,
        CURLOPT_POSTFIELDS => json_encode($payload),
        CURLOPT_HTTPHEADER => [
            'Authorization: Bearer ' . $apiKey,
            'Content-Type: application/json',
            'HTTP-Referer: https://cloudbaseindia.com',
            'X-Title: CloudBaseIndia AI',
        ],
        CURLOPT_TIMEOUT => 20
    ]);

    $response = curl_exec($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    $error = curl_error($ch);
    curl_close($ch);

    return [
        'success' => ($httpCode >= 200 && $httpCode < 300),
        'httpCode' => $httpCode,
        'response' => $response,
        'error' => $error
    ];
}

// 🔄 TRY MODELS ONE BY ONE
foreach ($models as $model) {

    $result = callOpenRouter($apiKey, $model, $messages);

    if ($result['success']) {
        $data = json_decode($result['response'], true);
        $reply = $data['choices'][0]['message']['content'] ?? null;

        if ($reply) {
            echo json_encode([
                'reply' => $reply,
                'model_used' => $model
            ]);
            exit;
        }
    }
}

// ❌ ALL MODELS FAILED
http_response_code(503);
echo json_encode([
    'error' => 'All AI models are currently unavailable. Please try again later. or Suppot Ticket'
]);
