--現世と冥界の逆転
local s,id=GetID()
function s.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_DRAW_PHASE)
	e1:SetCountLimit(1,id,EFFECT_COUNT_CODE_OATH+EFFECT_COUNT_CODE_DUEL)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
s.listed_series={0xe97}
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.SwapDeckAndGrave(1-tp)
end
