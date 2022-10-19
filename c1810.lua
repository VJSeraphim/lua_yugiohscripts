--灰流うらら
--Ghost Ash & Beautiful Spring
local s,id=GetID()
function s.initial_effect(c)
	--negatehand
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DISABLE)
	e1:SetType(EFFECT_TYPE_QUICK_O)
	e1:SetCode(EVENT_CHAINING)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(s.disconhand)
	e1:SetCost(s.discosthand)
	e1:SetTarget(s.distghand)
	e1:SetOperation(s.disophand)
	c:RegisterEffect(e1)
	--negategrave
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(id,0))
	e2:SetCategory(CATEGORY_NEGATE)
	e2:SetType(EFFECT_TYPE_QUICK_O)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DAMAGE_CAL)
	e2:SetCode(EVENT_CHAINING)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(s.discon)
	e2:SetCost(s.discost)
	e2:SetTarget(s.distg)
	e2:SetOperation(s.disop)
	c:RegisterEffect(e2)
end
s.listed_series={0xe97}
function s.disconhand(e,tp,eg,ep,ev,re,r,rp)
	if re:GetHandler():IsDisabled() then return false end
	local ex1,g1,gc1,dp1,dv1=Duel.GetOperationInfo(ev,CATEGORY_TOHAND)
	local ex2,g2,gc2,dp2,dv2=Duel.GetOperationInfo(ev,CATEGORY_SPECIAL_SUMMON)
	local ex3,g3,gc3,dp3,dv3=Duel.GetOperationInfo(ev,CATEGORY_TOGRAVE)
	local ex4=(Duel.GetOperationInfo(ev,CATEGORY_DRAW) or re:IsHasCategory(CATEGORY_DRAW))
	local ex5=(Duel.GetOperationInfo(ev,CATEGORY_SEARCH) or re:IsHasCategory(CATEGORY_SEARCH))
	local ex6=(Duel.GetOperationInfo(ev,CATEGORY_DECKDES) or re:IsHasCategory(CATEGORY_DECKDES))
	if not Duel.IsChainDisablable(ev) then return false end
	if (ex1 and (dv1&LOCATION_DECK)==LOCATION_DECK)
		or (ex2 and (dv2&LOCATION_DECK)==LOCATION_DECK)
		or (ex3 and (dv3&LOCATION_DECK)==LOCATION_DECK)
		or ex4 or ex5 or ex6 then return true end
	for i,eff in ipairs(AshBlossomTable) do
		if eff==re then return true end
	end
	return false
end
s.listed_series={0xe97}
function s.discosthand(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsDiscardable() end
	Duel.SendtoGrave(c,REASON_COST+REASON_DISCARD)
end
function s.distghand(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return not re:GetHandler():IsStatus(STATUS_DISABLED) end
	Duel.SetOperationInfo(0,CATEGORY_DISABLE,eg,1,0,0)
end
function s.disophand(e,tp,eg,ep,ev,re,r,rp)
	Duel.NegateEffect(ev)
end
function s.discon(e,tp,eg,ep,ev,re,r,rp)
	if not Duel.IsChainNegatable(ev) then return false end
	local ex1,g1,gc1,dp1,loc1=Duel.GetOperationInfo(ev,CATEGORY_TOHAND)
	local ex2,g2,gc2,dp2,loc2=Duel.GetOperationInfo(ev,CATEGORY_TODECK)
	local ex3,g3,gc3,dp3,loc3=Duel.GetOperationInfo(ev,CATEGORY_SPECIAL_SUMMON)
	local ex4,g4,gc4,dp4,loc4=Duel.GetOperationInfo(ev,CATEGORY_REMOVE)
	if (ex1 and loc1&LOCATION_GRAVE==LOCATION_GRAVE)
		or (ex2 and loc2&LOCATION_GRAVE==LOCATION_GRAVE) 
		or (ex3 and loc3&LOCATION_GRAVE==LOCATION_GRAVE)
		or (ex4 and loc4&LOCATION_GRAVE==LOCATION_GRAVE) 
		or (ex1 and g1 and g1:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE))
		or (ex2 and g2 and g2:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE)) 
		or (ex3 and g3 and g3:IsExists(function (c) return c:IsType(TYPE_MONSTER) and c:IsLocation(LOCATION_GRAVE) end,1,nil))
		or (ex4 and g4 and g4:IsExists(Card.IsLocation,1,nil,LOCATION_GRAVE))
		then return true
	end
	for i,eff in ipairs(GhostBelleTable) do
		if eff==re then return true end
	end
	return false
end
function s.discost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDiscardable() end
	Duel.SendtoGrave(e:GetHandler(),REASON_COST+REASON_DISCARD)
end
function s.distg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_NEGATE,eg,1,0,0)
end
function s.disop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.NegateActivation(ev) and re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:GetHandler():IsRelateToEffect(re) then
		Duel.SendtoGrave(eg,REASON_EFFECT)
	end
end
