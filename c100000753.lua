--gate
function c100000753.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Attach
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(100000753,0))
	e4:SetType(EFFECT_TYPE_IGNITION)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1)
	e4:SetCost(c100000753.cost)
	e4:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e4:SetTarget(c100000753.target)
	e4:SetOperation(c100000753.operation)
	c:RegisterEffect(e4)
end
function c100000753.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.CheckLPCost(tp,300) end
	Duel.PayLPCost(tp,300)
end
function c100000753.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x11A) and c:IsType(TYPE_XYZ)
end
function c100000753.filter2(c)
	return c:IsSetCard(0x11A) and c:IsType(TYPE_MONSTER)
end
function c100000753.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000753.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000753.filter,tp,LOCATION_MZONE,0,1,nil)
		and Duel.IsExistingMatchingCard(c100000753.filter2,tp,LOCATION_HAND,0,1,nil,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	Duel.SelectTarget(tp,c100000753.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c100000753.operation(e,tp,eg,ep,ev,re,r,rp)
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and not tc:IsImmuneToEffect(e) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_XMATERIAL)
		local g=Duel.SelectMatchingCard(tp,c100000753.filter2,tp,LOCATION_HAND,0,1,1,nil,nil)
		if g:GetCount()>0 then
			Duel.Overlay(tc,g)
		end
	end
end
