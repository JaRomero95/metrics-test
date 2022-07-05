import {ReactNode} from 'react';
import styled from 'styled-components'
import AppTitle from 'components/AppTitle'

interface iProps {
  children: ReactNode,
  title: string
}

function DefaultLayout({children, title}: iProps) {
  return (
    <StyledContainer>
      <AppTitle title={title} />

      <Content>
        {children}
      </Content>
    </StyledContainer>
  );
}

const StyledContainer = styled.div`
  padding: 0.2rem 1rem;
`

const Content = styled.div`
  margin: 1rem 0 0 0;
`

export default DefaultLayout;
