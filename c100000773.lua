--Created and scripted by Rising Phoenix
function c100000773.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,100000773+EFFECT_COUNT_CODE_OATH)
	e1:SetCost(c100000773.cost)
	e1:SetTarget(c100000773.target)
	e1:SetOperation(c100000773.activate)
	c:RegisterEffect(e1)
		--damage
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000773,0))
	e2:SetCategory(CATEGORY_DAMAGE)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e2:SetRange(LOCATION_GRAVE)
		e2:SetCost(c100000773.spcost)
	e2:SetCountLimit(1,100000773+EFFECT_COUNT_CODE_OATH)
	e2:SetTarget(c100000773.damtg)
	e2:SetOperation(c100000773.damop)
		e2:SetHintTiming(TIMING_STANDBY_PHASE,0)
	c:RegisterEffect(e2)
end
function c100000773.spcost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsAbleToRemoveAsCost() end
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_COST)
end
function c100000773.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000773.filterb,tp,LOCATION_MZONE,0,1,nil,nil) end
	local dam=Duel.GetMatchingGroupCount(c100000773.filterb,tp,LOCATION_MZONE,0,nil,nil)*800
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(dam)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,dam)
end
function c100000773.damop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local d=Duel.GetMatchingGroupCount(c100000773.filterb,tp,LOCATION_MZONE,0,nil,nil)*800
	Duel.Damage(p,d,REASON_EFFECT)
end
function c100000773.filterb(c)
	return c:IsSetCard(0x10E) and c:IsType(TYPE_MONSTER)
end
function c100000773.filter(c)
	return c:IsSetCard(0x10E) and c:IsAbleToRemoveAsCost()
end
function c100000773.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000773.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local g=Duel.SelectMatchingCard(tp,c100000773.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.Remove(g,POS_FACEUP,REASON_COST)
end
function c100000773.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp,2) end
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,tp,2)
end
function c100000773.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Draw(p,d,REASON_EFFECT)
end
