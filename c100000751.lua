function c100000751.initial_effect(c)
aux.AddSynchroProcedure(c,nil,aux.NonTuner(nil),1)
	c:EnableReviveLimit()
		local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DIRECT_ATTACK)
	e1:SetCondition(c100000751.dircon)
	c:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e2:SetCondition(c100000751.rdcon)
	e2:SetOperation(c100000751.rdop)
	c:RegisterEffect(e2)
end
function c100000751.rdcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return ep~=tp and Duel.GetAttackTarget()==nil
		and c:GetEffectCount(EFFECT_DIRECT_ATTACK)<2
end
function c100000751.rdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(ep,ev/2)
end
function c100000751.filter2(c)
	return c:IsFaceup() and c:IsCode(100000989)
end
function c100000751.dircon(e)
local tp=e:GetHandlerPlayer()
	return Duel.IsExistingMatchingCard(c100000751.filter2,0,LOCATION_ONFIELD,LOCATION_ONFIELD,1,nil)
		or Duel.IsEnvironment(100000989)
end
function c100000751.atkval(e,c)
	return c:GetAttack()/2
end