import {useEffect, useState} from 'react';
import {useTranslation} from 'react-i18next';
import styled from 'styled-components'
import variables from 'variables'
import {getCurrentDate, substractDays, formatDateBasic} from 'utils/date'
import AppInputDatetime from 'components/AppInputDatetime'
import AppInputSelect from 'components/AppInputSelect'

const initialDatetimeFrom = formatDateBasic(substractDays(getCurrentDate(), 10))
const initialDatetimeUntil = formatDateBasic(getCurrentDate())

export interface iFilters {
  groupBy: string,
  datetimeFrom: string,
  datetimeUntil: string
}

interface iProps {
  onFiltersChanged: (filter: iFilters) => void
}

function GroupMetricsFilters({onFiltersChanged}: iProps) {
  const {t} = useTranslation();
  const [groupBy, setGroupBy] = useState('days')
  const [datetimeFrom, setDatetimeFrom] = useState(initialDatetimeFrom)
  const [datetimeUntil, setDatetimeUntil] = useState(initialDatetimeUntil)

  useEffect(() => {
    onFiltersChanged({groupBy, datetimeFrom, datetimeUntil})
  }, [onFiltersChanged, groupBy, datetimeFrom, datetimeUntil])

  return (
      <Container>
        <AppInputSelect
          label={t('groupBy')}
          value={groupBy}
          onChange={setGroupBy}
          options={[
            {value: 'days', label: t('days')},
            {value: 'hours', label: t('hours')},
            {value: 'minutes', label: t('minutes')}
          ]}
        />

        <AppInputDatetime
          label={t('datetimeFrom')}
          value={datetimeFrom}
          onChange={setDatetimeFrom}
        />

        <AppInputDatetime
          label={t('datetimeUntil')}
          value={datetimeUntil}
          onChange={setDatetimeUntil}
        />
      </Container>
  );
}

const Container = styled.div`
  > * {
    width: 100%;
  }

  @media (min-width: ${variables.breakpointSM}px) {
    display: flex;
    gap: 1em;
  }
`

export default GroupMetricsFilters;
