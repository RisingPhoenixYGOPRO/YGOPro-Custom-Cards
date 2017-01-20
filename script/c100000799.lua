 --Created and coded by Rising Phoenix
function c100000799.initial_effect(c)
aux.AddEquipProcedure(c,0,c100000799.filtere)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_SZONE)
	e1:SetCost(c100000799.cost)
	e1:SetTarget(c100000799.target)
	e1:SetOperation(c100000799.activate)
	c:RegisterEffect(e1)
		local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_REMOVE)
	e6:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e6:SetCode(EVENT_TO_GRAVE)
	e6:SetProperty(EFFECT_FLAG_DAMAGE_STEP+EFFECT_FLAG_DELAY)
	e6:SetCondition(c100000799.thcon)
	e6:SetTarget(c100000799.thtg)
	e6:SetOperation(c100000799.thop)
	c:RegisterEffect(e6)
end
function c100000799.filter3(c)
	return c:IsAbleToRemove() and c:IsType(TYPE_SPELL) or c:IsType(TYPE_TRAP)
end
function c100000799.thcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return e:GetHandler():IsPreviousPosition(POS_FACEUP) and e:GetHandler():IsPreviousLocation(LOCATION_ONFIELD)
end
function c100000799.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,0,LOCATION_HAND)>0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_REMOVE,nil,0,1-tp,LOCATION_HAND)
end
function c100000799.thop(e,tp,eg,ep,ev,re,r,rp)
		local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local g=Duel.GetMatchingGroup(c100000799.filter3,p,0,LOCATION_HAND,nil,nil)
	if g:GetCount()>0 then end
		Duel.ConfirmCards(p,g)
		Duel.Hint(HINT_SELECTMSG,p,HINTMSG_REMOVE)
		local sg=g:Select(p,1,1,nil)
		Duel.Remove(sg,POS_FACEUP,2,REASON_EFFECT)
		Duel.ShuffleHand(1-p)
end
function c100000799.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsAbleToGraveAsCost() and c:GetControler()==c:GetEquipTarget():GetControler()
		and c:GetEquipTarget():IsAbleToGraveAsCost() end
	local g=Group.FromCards(c,c:GetEquipTarget())
	Duel.SendtoGrave(g,REASON_COST)
end
function c100000799.filtere(c)
	return c:IsFaceup() and c:IsCode(100000797)
end
function c100000799.filter(c,e,tp)
	return  c:IsCode(100000798) and c:IsCanBeSpecialSummoned(e,0,tp,true,false) 
end
function c100000799.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c100000799.filter,tp,LOCATION_EXTRA,0,1,nil,e,tp) end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,LOCATION_EXTRA)
end
function c100000799.activate(e,tp,eg,ep,ev,re,r,rp)
		if  Duel.GetLocationCount(tp,LOCATION_MZONE)>0 then end
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectMatchingCard(tp,c100000799.filter,tp,LOCATION_EXTRA,0,1,1,nil,e,tp)
	if g:GetCount()>0 then end
	Duel.SpecialSummon(g,0,tp,tp,true,false,POS_FACEUP)
end
