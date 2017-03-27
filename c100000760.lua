--Created and scripted by Rising Phoenix
function c100000760.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TODECK+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000760.target)
	e1:SetOperation(c100000760.activate)
	c:RegisterEffect(e1)
end
function c100000760.filter(c)
	return c:IsSetCard(0x11A) and c:IsType(TYPE_MONSTER) and c:IsAbleToDeck()
end
function c100000760.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(tp)
		and Duel.IsExistingMatchingCard(c100000760.filter,tp,LOCATION_GRAVE,0,1,e:GetHandler()) end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_TODECK,nil,1,tp,LOCATION_GRAVE)
end
function c100000760.activate(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	Duel.Hint(HINT_SELECTMSG,p,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(p,c100000760.filter,p,LOCATION_GRAVE,0,1,63,nil)
	if g:GetCount()>0 then end
		Duel.ConfirmCards(1-p,g)
		local ct=Duel.SendtoDeck(g,nil,2,REASON_EFFECT)
		Duel.ShuffleDeck(p)
	local og=Duel.GetOperatedGroup()
			local ct=og:FilterCount(c100000760.filter,nil)
			if ct>0 then end
				Duel.Recover(tp,ct*500,REASON_EFFECT)
	end