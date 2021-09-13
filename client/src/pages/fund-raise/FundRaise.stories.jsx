import React, { useState } from 'react';
import FundRaise from './FundRaise';

export default {
  title: 'Pages/FundRaise',
  component: FundRaise
};

const Template = (args) => {
  const [show, setShow] = useState(false)

  const donateModal = {
    show,
    onChange: undefined,
    onClick: () => setShow(true),
    onClose: () => setShow(false),
    onSubmit: event => event.preventDefault() 
  }

  args = { ...args, donateModal }

  return (
    <FundRaise {...args}/>
  )
};

export const FundRaiseStory = Template.bind({});
FundRaiseStory.args = {
  title: 'First Fundraiser',
  id: 0,
  description: 'This is my first fund raiser for my dApp idea',
  current: 500,
  goal: 3000,
  // donateModal: {} (defined above)
};