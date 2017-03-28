--Created and scripted by Rising Phoenix
function c100000763.initial_effect(c)
		--splimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_CANNOT_SPECIAL_SUMMON)
	e2:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(1,0)
	e2:SetTarget(c100000763.splimit)
	c:RegisterEffect(e2)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(100000763,0))
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e1:SetRange(LOCATION_DECK)
	e1:SetCode(EVENT_MSET)
	e1:SetCondition(c100000763.spcon)
	e1:SetTarget(c100000763.sptg)
	e1:SetOperation(c100000763.spop)
	e1:SetCountLimit(1,100000763)
	c:RegisterEffect(e1)
		local e6=e1:Clone()
	e6:SetCode(EVENT_SSET)
	c:RegisterEffect(e6)
		--cannot release
	local e12=Effect.CreateEffect(c)
	e12:SetType(EFFECT_TYPE_FIELD)
	e12:SetRange(LOCATION_MZONE)
	e12:SetCode(EFFECT_CANNOT_RELEASE)
	e12:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_CANNOT_NEGATE)
	e12:SetTargetRange(1,0)
	c:RegisterEffect(e12)
	--atkup
	local e13=Effect.CreateEffect(c)
	e13:SetType(EFFECT_TYPE_SINGLE)
	e13:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e13:SetRange(LOCATION_MZONE)
	e13:SetCode(EFFECT_UPDATE_ATTACK)
	e13:SetValue(c100000763.atkup)
	c:RegisterEffect(e13)
end
function c100000763.atkfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x11A)
end
function c100000763.atkup(e,c)
	return Duel.GetMatchingGroupCount(c100000763.atkfilter,c:GetControler(),LOCATION_MZONE,0,nil)*200
end
function c100000763.splimit(e,c)
	return not c:IsSetCard(0x11A)
end
function c100000763.spcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function c100000763.sptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and e:GetHandler():IsCanBeSpecialSummoned(e,0,tp,false,false) end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,e:GetHandler(),1,0,0)
end
function c100000763.spop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	if Duel.SpecialSummon(c,0,tp,tp,false,false,POS_FACEUP)==0 and Duel.GetLocationCount(tp,LOCATION_MZONE)<=0
		and c:IsCanBeSpecialSummoned(e,0,tp,false,false) then
		Duel.SendtoGrave(c,REASON_RULE)
	end
end